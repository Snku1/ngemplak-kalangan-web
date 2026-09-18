// src/composables/useAutoLogout.js
import { ref, onMounted, onUnmounted } from 'vue';
import { store } from '../store';

export function useAutoLogout({ idleMinutes = 30, warningMinutes = 2 } = {}) {
  const showWarning = ref(false);
  const countdown = ref(0); // ← nilai dalam DETIK (integer)

  let idleTimer = null;
  let warningTimer = null;
  let countdownInterval = null;
  let lastActivity = 0;

  const ACTIVITY_THROTTLE = 5000;

  const clearAllTimers = () => {
    clearTimeout(idleTimer);
    clearTimeout(warningTimer);
    clearInterval(countdownInterval);
    idleTimer = warningTimer = countdownInterval = null;
  };

  const resetTimers = () => {
    clearAllTimers();
    showWarning.value = false;
    countdown.value = 0;

    if (!store.isAuthenticated) return;

    // ⚠️ Pakai Math.round supaya bulat, tidak ada desimal aneh
    const warningAt = Math.round((idleMinutes - warningMinutes) * 60 * 1000);
    const logoutAt  = Math.round(idleMinutes * 60 * 1000);
    const warningSeconds = Math.max(1, Math.round(warningMinutes * 60)); // ← integer detik

    warningTimer = setTimeout(() => {
      if (!store.isAuthenticated) return;
      showWarning.value = true;
      countdown.value = warningSeconds; // ← set integer, bukan desimal

      countdownInterval = setInterval(() => {
        countdown.value = Math.max(0, countdown.value - 1); // ← selalu >= 0, integer
        if (countdown.value <= 0) {
          clearInterval(countdownInterval);
          countdownInterval = null;
        }
      }, 1000);
    }, warningAt);

    idleTimer = setTimeout(() => {
      if (!store.isAuthenticated) return;
      console.warn('[AutoLogout] Idle timeout → logout');
      store.logout();
      showWarning.value = false;

      if (window.location.pathname.toLowerCase().startsWith('/admin')) {
        window.history.pushState({}, '', '/');
        window.dispatchEvent(new PopStateEvent('popstate'));
      }
    }, logoutAt);
  };

  const handleActivity = () => {
    if (!store.isAuthenticated) return;
    const now = Date.now();
    if (now - lastActivity < ACTIVITY_THROTTLE) return;
    lastActivity = now;
    resetTimers();
  };

  const stayLoggedIn = () => {
    lastActivity = Date.now();
    resetTimers();
  };

  onMounted(() => {
    window.addEventListener('mousemove', handleActivity, { passive: true });
    window.addEventListener('keydown', handleActivity, { passive: true });
    window.addEventListener('click', handleActivity, { passive: true });
    window.addEventListener('scroll', handleActivity, { passive: true });
    window.addEventListener('touchstart', handleActivity, { passive: true });
    window.addEventListener('focus', handleActivity, { passive: true });
    resetTimers();
  });

  onUnmounted(() => {
    window.removeEventListener('mousemove', handleActivity);
    window.removeEventListener('keydown', handleActivity);
    window.removeEventListener('click', handleActivity);
    window.removeEventListener('scroll', handleActivity);
    window.removeEventListener('touchstart', handleActivity);
    window.removeEventListener('focus', handleActivity);
    clearAllTimers();
  });

  return { showWarning, countdown, stayLoggedIn };
}