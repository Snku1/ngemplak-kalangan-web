<template>
  <div class="min-h-screen bg-gradient-to-br from-[#063825] via-[#0D6847] to-[#042418] flex items-center justify-center p-4 relative overflow-hidden text-white">
    
    <!-- Background Floating Light Blobs & Decorative Pattern -->
    <div class="absolute -top-32 -left-32 w-96 h-96 bg-emerald-400/20 rounded-full blur-3xl pointer-events-none"></div>
    <div class="absolute -bottom-32 -right-32 w-96 h-96 bg-teal-400/15 rounded-full blur-3xl pointer-events-none"></div>
    <div class="absolute inset-0 opacity-10 bg-[radial-gradient(#fff_1px,transparent_1px)] [background-size:20px_20px] pointer-events-none"></div>

    <!-- Main Login Card Container -->
    <div class="relative z-10 w-full max-w-md bg-white/95 backdrop-blur-xl rounded-3xl p-8 sm:p-10 shadow-2xl border border-white/40 text-gray-900 animate-fade-in">
      
      <!-- Back to Public Site Button -->
      <button 
        @click="$emit('navigate', 'beranda')"
        class="inline-flex items-center gap-1.5 text-xs font-bold text-gray-400 hover:text-[#0D6847] transition-colors mb-6 cursor-pointer"
      >
        <ArrowLeftIcon class="w-4 h-4" />
        <span>Kembali ke Website Desa</span>
      </button>

      <!-- Header Icon & Titles -->
      <div class="text-center mb-8">
        <div class="w-16 h-16 rounded-2xl bg-gradient-to-tr from-[#0D6847] to-emerald-500 text-white flex items-center justify-center mx-auto mb-4 shadow-lg shadow-emerald-900/30">
          <ShieldLockIcon class="w-8 h-8" />
        </div>
        <h2 class="text-2xl font-black text-gray-900 tracking-tight">Panel Administrasi</h2>
        <p class="text-xs text-gray-500 mt-1.5 font-medium">Padukuhan Ngemplak Kalangan, Kalasan</p>
      </div>

      <!-- Credentials Hint Banner (Requested: user: admin, password: admin12345) -->
      <div class="bg-emerald-50/90 border border-emerald-200 rounded-2xl p-4 mb-6 text-xs text-emerald-900 flex items-center justify-between gap-3">
        <div class="space-y-1">
          <p class="font-bold flex items-center gap-1.5">
            <KeyIcon class="w-3.5 h-3.5 text-[#0D6847]" />
            <span>Kredensial Login Admin:</span>
          </p>
          <p class="text-[11px] font-mono text-emerald-800">
            Email: <strong class="text-[#0D6847]">admin@gmail.com</strong> | Sandi: <strong class="text-[#0D6847]">admin123</strong>
          </p>
        </div>
        <button 
          @click="fillDemoCredentials"
          class="px-2.5 py-1.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-[10px] font-bold rounded-lg transition-colors cursor-pointer shrink-0"
        >
          Isi Otomatis
        </button>
      </div>

      <!-- Error Alert Message -->
      <div 
        v-if="errorMessage" 
        class="bg-red-50 border border-red-200 rounded-2xl p-3.5 mb-5 text-xs text-red-700 flex items-start gap-2.5 animate-shake"
      >
        <AlertCircleIcon class="w-4 h-4 text-red-500 shrink-0 mt-0.5" />
        <span>{{ errorMessage }}</span>
      </div>

      <!-- Login Form -->
      <form @submit.prevent="handleLogin" class="space-y-4.5">
        <!-- Email Input -->
        <div>
          <label class="block text-xs font-bold text-gray-700 uppercase tracking-wider mb-1.5">Alamat Email</label>
          <div class="relative">
            <div class="w-10 h-full absolute left-0 top-0 flex items-center justify-center text-gray-400">
              <UserIcon class="w-4.5 h-4.5" />
            </div>
            <input 
              v-model="email" 
              type="email" 
              required
              placeholder="Masukkan email"
              class="w-full pl-10 pr-4 py-3 bg-gray-50/80 border border-gray-200 rounded-xl text-xs sm:text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:border-[#0D6847] focus:bg-white focus:ring-2 focus:ring-[#0D6847]/20 transition-all font-medium"
            />
          </div>
        </div>

        <!-- Password Input -->
        <div>
          <label class="block text-xs font-bold text-gray-700 uppercase tracking-wider mb-1.5">Kata Sandi (Password)</label>
          <div class="relative">
            <div class="w-10 h-full absolute left-0 top-0 flex items-center justify-center text-gray-400">
              <LockIcon class="w-4.5 h-4.5" />
            </div>
            <input 
              v-model="password" 
              :type="showPassword ? 'text' : 'password'" 
              required
              placeholder="Masukkan kata sandi"
              class="w-full pl-10 pr-11 py-3 bg-gray-50/80 border border-gray-200 rounded-xl text-xs sm:text-sm text-gray-900 placeholder-gray-400 focus:outline-none focus:border-[#0D6847] focus:bg-white focus:ring-2 focus:ring-[#0D6847]/20 transition-all font-medium"
            />
            <button 
              type="button" 
              @click="showPassword = !showPassword"
              class="absolute right-3.5 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 p-1 cursor-pointer"
            >
              <EyeOffIcon v-if="showPassword" class="w-4 h-4" />
              <EyeIcon v-else class="w-4 h-4" />
            </button>
          </div>
        </div>

        <!-- Submit Button -->
        <button 
          type="submit" 
          :disabled="isLoading"
          class="w-full mt-2 py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs sm:text-sm font-bold rounded-xl shadow-lg shadow-emerald-950/20 hover:shadow-xl transition-all duration-300 active:scale-98 cursor-pointer flex items-center justify-center gap-2 disabled:opacity-60"
        >
          <div v-if="isLoading" class="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin"></div>
          <span v-if="isLoading">Memverifikasi Kredensial...</span>
          <span v-else>Masuk ke Panel Admin</span>
          <LogInIcon v-if="!isLoading" class="w-4 h-4" />
        </button>
      </form>

      <div class="mt-8 pt-6 border-t border-gray-150 text-center">
        <p class="text-[11px] text-gray-400 font-semibold">
          Sistem Pengelolaan Informasi Desa Terpadu • Versi 2.4
        </p>
      </div>

    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { 
  ShieldAlert as ShieldLockIcon, 
  ArrowLeft as ArrowLeftIcon, 
  User as UserIcon, 
  Lock as LockIcon, 
  Eye as EyeIcon, 
  EyeOff as EyeOffIcon, 
  LogIn as LogInIcon, 
  Key as KeyIcon, 
  AlertCircle as AlertCircleIcon 
} from 'lucide-vue-next';
import { store } from '../../store';

const emit = defineEmits(['navigate', 'login-success']);

const email = ref('');
const password = ref('');
const showPassword = ref(false);
const errorMessage = ref('');
const isLoading = ref(false);

const fillDemoCredentials = () => {
  email.value = 'admin@gmail.com';
  password.value = 'admin123';
  errorMessage.value = '';
};

const handleLogin = () => {
  errorMessage.value = '';
  isLoading.value = true;

  setTimeout(async () => {
    const res = await store.login(email.value.trim(), password.value.trim());
    isLoading.value = false;

    if (res.success) {
      emit('login-success');
      emit('navigate', 'admin-dashboard');
    } else {
      errorMessage.value = res.message;
    }
  }, 600);
};
</script>

<style scoped>
@keyframes fadeIn {
  from { opacity: 0; transform: scale(0.95) translateY(10px); }
  to { opacity: 1; transform: scale(1) translateY(0); }
}

.animate-fade-in {
  animation: fadeIn 0.3s cubic-bezier(0.16, 1, 0.3, 1) forwards;
}

@keyframes shake {
  0%, 100% { transform: translateX(0); }
  20%, 60% { transform: translateX(-4px); }
  40%, 80% { transform: translateX(4px); }
}

.animate-shake {
  animation: shake 0.35s ease-in-out;
}
</style>
