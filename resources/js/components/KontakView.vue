<template>
  <div>
    <!-- HERO SECTION -->
    <section class="relative min-h-[400px] md:min-h-[480px] flex items-center justify-center overflow-hidden bg-gray-900 text-white">
      <div class="absolute inset-0 z-0">
        <img
          src="/images/hero-bg.png"
          alt="Latar Belakang Kontak"
          class="w-full h-full object-cover object-center opacity-60 scale-105"
          @error="handleImageError($event, 'hero-bg')"
        />
        <div class="absolute inset-0 bg-gradient-to-b from-[#0D6847]/90 via-[#0D6847]/75 to-gray-950/85"></div>
      </div>

      <div class="relative z-10 max-w-4xl mx-auto px-4 text-center py-20">
        <h1 class="text-3xl md:text-5xl font-extrabold tracking-tight leading-tight mb-4 text-white">
          Kontak &amp; Layanan Padukuhan
        </h1>
        <p class="text-sm md:text-base text-emerald-100 max-w-2xl mx-auto leading-relaxed font-medium">
          Kami siap membantu. Hubungi kami untuk informasi, pertanyaan, atau keperluan administrasi.
        </p>
      </div>
    </section>

    <!-- CONTACT INFO CARDS -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 -mt-10 relative z-20">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <!-- Alamat -->
        <div class="bg-white rounded-2xl p-6 shadow-xl border border-gray-100 hover:shadow-2xl transition-all">
          <div class="w-12 h-12 rounded-xl bg-emerald-50 text-[#0D6847] flex items-center justify-center mb-4">
            <MapPinIcon class="w-6 h-6" />
          </div>
          <h3 class="text-base font-extrabold text-gray-900 mb-2">Alamat Kantor</h3>
          <p class="text-xs text-gray-600 leading-relaxed">
            {{ store.padukuhanProfile?.alamat_kantor || 'Jl. Utama Desa No. 123, Kec. Kalasan, Kab. Sleman, D.I. Yogyakarta' }}
          </p>
        </div>

        <!-- Telepon -->
        <div class="bg-white rounded-2xl p-6 shadow-xl border border-gray-100 hover:shadow-2xl transition-all">
          <div class="w-12 h-12 rounded-xl bg-blue-50 text-blue-600 flex items-center justify-center mb-4">
            <PhoneIcon class="w-6 h-6" />
          </div>
          <h3 class="text-base font-extrabold text-gray-900 mb-2">Telepon & WhatsApp</h3>
          <a :href="`tel:${(store.padukuhanProfile?.telepon || '').replace(/[^0-9]/g, '')}`" class="text-xs text-gray-600 leading-relaxed hover:text-[#0D6847] block">
            {{ store.padukuhanProfile?.telepon || '(0274) 555-8123' }}
          </a>
        </div>

        <!-- Email -->
        <div class="bg-white rounded-2xl p-6 shadow-xl border border-gray-100 hover:shadow-2xl transition-all">
          <div class="w-12 h-12 rounded-xl bg-amber-50 text-amber-600 flex items-center justify-center mb-4">
            <MailIcon class="w-6 h-6" />
          </div>
          <h3 class="text-base font-extrabold text-gray-900 mb-2">Email Resmi</h3>
          <a :href="`mailto:${store.padukuhanProfile?.email || 'admin@ngempakkan.id'}`" class="text-xs text-gray-600 leading-relaxed hover:text-[#0D6847] break-all">
            {{ store.padukuhanProfile?.email || 'admin@ngempakkan.id' }}
          </a>
        </div>
      </div>
    </section>

    <!-- FORM & MAPS -->
    <section class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">

      <!-- Grid Form + Maps (Equal Height) -->
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 items-stretch mb-8">

        <!-- FORM KONTAK -->
        <div class="bg-white rounded-3xl p-6 sm:p-8 border border-gray-100 shadow-sm flex flex-col">
          <h3 class="text-xl font-extrabold text-gray-900 mb-2 flex items-center gap-2">
            <MessageSquareIcon class="w-5 h-5 text-[#0D6847]" />
            <span>Kirim Pesan</span>
          </h3>
          <p class="text-xs text-gray-500 mb-6">Isi form di bawah ini, kami akan merespons secepat mungkin.</p>

          <form @submit.prevent="submitForm" class="space-y-4 flex-1 flex flex-col">
            <div>
              <label class="block text-xs font-bold text-gray-700 mb-1.5">Nama Lengkap <span class="text-red-500">*</span></label>
              <input v-model="form.name" type="text" required placeholder="Nama Anda" class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs focus:outline-none focus:border-[#0D6847] focus:bg-white transition-all" />
            </div>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1.5">No. WhatsApp <span class="text-red-500">*</span></label>
                <input v-model="form.phone" type="text" required placeholder="08xxxxxxxxxx" class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs focus:outline-none focus:border-[#0D6847] focus:bg-white transition-all" />
              </div>
              <div>
                <label class="block text-xs font-bold text-gray-700 mb-1.5">Email</label>
                <input v-model="form.email" type="email" placeholder="nama@email.com" class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs focus:outline-none focus:border-[#0D6847] focus:bg-white transition-all" />
              </div>
            </div>
            <div class="flex-1 flex flex-col">
              <label class="block text-xs font-bold text-gray-700 mb-1.5">Pesan <span class="text-red-500">*</span></label>
              <textarea v-model="form.message" required placeholder="Tuliskan pesan atau pertanyaan Anda..." class="w-full px-4 py-2.5 bg-gray-50 border border-gray-200 rounded-xl text-xs focus:outline-none focus:border-[#0D6847] focus:bg-white transition-all flex-1 min-h-[140px] resize-none"></textarea>
            </div>
            <button type="submit" :disabled="submitting" class="w-full py-3.5 bg-[#0D6847] hover:bg-[#0A5238] text-white text-xs font-bold rounded-xl shadow-md transition-all cursor-pointer disabled:opacity-50 flex items-center justify-center gap-2">
              <SendIcon v-if="!submitting" class="w-4 h-4" />
              <span>{{ submitting ? 'Mengirim...' : 'Kirim Pesan' }}</span>
            </button>
          </form>
        </div>

        <!-- MAPS -->
        <div class="bg-white rounded-3xl overflow-hidden border border-gray-100 shadow-sm flex flex-col">
          <div class="p-6 pb-3 shrink-0">
            <h3 class="text-lg font-extrabold text-gray-900 flex items-center gap-2">
              <MapPinIcon class="w-5 h-5 text-[#0D6847]" />
              <span>Lokasi Kantor Padukuhan</span>
            </h3>
            <p class="text-xs text-gray-500 mt-1">Kantor Kepala Dukuh {{ store.padukuhanProfile?.nama_dukuh || 'Padukuhan' }}</p>
          </div>
          <div class="flex-1 bg-gray-100 min-h-[360px]">
            <iframe
              :src="officeMapEmbed"
              width="100%" height="100%" style="border:0; min-height: 360px;" loading="lazy"
              referrerpolicy="no-referrer-when-downgrade">
            </iframe>
          </div>
        </div>

      </div>

      <!-- Jam Operasional (Full Width) -->
      <div class="bg-white rounded-3xl p-6 border border-gray-100 shadow-sm">
        <h3 class="text-lg font-extrabold text-gray-900 mb-4 flex items-center gap-2">
          <ClockIcon class="w-5 h-5 text-[#0D6847]" />
          <span>Jam Operasional</span>
        </h3>
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          <div class="flex items-center justify-between p-4 bg-gray-50 rounded-xl border border-gray-100">
            <span class="text-xs font-bold text-gray-700">Senin - Kamis</span>
            <span class="text-xs font-bold text-[#0D6847]">08:00 - 15:00</span>
          </div>
          <div class="flex items-center justify-between p-4 bg-gray-50 rounded-xl border border-gray-100">
            <span class="text-xs font-bold text-gray-700">Jumat</span>
            <span class="text-xs font-bold text-[#0D6847]">08:00 - 11:00</span>
          </div>
          <div class="flex items-center justify-between p-4 bg-red-50/50 rounded-xl border border-red-100">
            <span class="text-xs font-bold text-gray-700">Sabtu - Minggu</span>
            <span class="text-xs font-bold text-red-500">Tutup</span>
          </div>
          <div class="flex items-center justify-between p-4 bg-red-50/50 rounded-xl border border-red-100">
            <span class="text-xs font-bold text-gray-700">Hari Libur</span>
            <span class="text-xs font-bold text-red-500">Tutup</span>
          </div>
        </div>
      </div>

    </section>

    <!-- TOAST -->
    <transition name="fade">
      <div v-if="toast" class="fixed bottom-6 right-6 z-50 flex items-center gap-3 px-5 py-3.5 bg-gray-900 text-white rounded-2xl shadow-xl">
        <CheckCircleIcon class="w-5 h-5 text-emerald-400 shrink-0" />
        <span class="text-xs font-bold">{{ toast }}</span>
      </div>
    </transition>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';
import {
  MapPin as MapPinIcon,
  Phone as PhoneIcon,
  Mail as MailIcon,
  MessageSquare as MessageSquareIcon,
  Clock as ClockIcon,
  Send as SendIcon,
  CheckCircle as CheckCircleIcon
} from 'lucide-vue-next';
import { store } from '../store';

const form = ref({ name: '', phone: '', email: '', message: '' });
const submitting = ref(false);
const toast = ref('');

const officeMapEmbed = computed(() => {
  // Prioritas 1: pakai maps_embed dari profil padukuhan (jika ada & mengandung koordinat)
  const url = store.padukuhanProfile?.maps_embed;
  const result = getOSMEmbedUrl(url);
  
  // Jika hasil embed mengandung marker → artinya ada koordinat → pakai itu
  if (result.includes('marker=')) return result;
  
  // Fallback 1: coba cari koordinat dari alamat (opsional, hanya jika Anda punya data)
  // Fallback 2: default ke Yogyakarta dengan pin
  const defaultLat = -7.7828;
  const defaultLon = 110.3671;
  const d = 0.008;
  return `https://www.openstreetmap.org/export/embed.html?bbox=${defaultLon - d},${defaultLat - d},${defaultLon + d},${defaultLat + d}&layer=mapnik&marker=${defaultLat},${defaultLon}`;
});

const getOSMEmbedUrl = (url) => {
  if (!url) return 'https://www.openstreetmap.org/export/embed.html?bbox=110.30,-7.80,110.45,-7.65&layer=mapnik';
  let lat = null, lon = null;
  const m1 = url.match(/@(-?\d+\.\d+),(-?\d+\.\d+)/);
  if (m1) { lat = parseFloat(m1[1]); lon = parseFloat(m1[2]); }
  if (!lat) {
    const m2 = url.match(/[?&]q=(?:loc:)?(-?\d+\.\d+),(-?\d+\.\d+)/);
    if (m2) { lat = parseFloat(m2[1]); lon = parseFloat(m2[2]); }
  }
  if (!lat) {
    const m3d = url.match(/!3d(-?\d+\.\d+)/);
    const m4d = url.match(/!4d(-?\d+\.\d+)/);
    if (m3d && m4d) { lat = parseFloat(m3d[1]); lon = parseFloat(m4d[1]); }
  }
  if (!lat) {
    const m4 = url.match(/(-?\d{1,3}\.\d{4,}),(-?\d{1,3}\.\d{4,})/);
    if (m4) { lat = parseFloat(m4[1]); lon = parseFloat(m4[2]); }
  }
  if (lat !== null && lon !== null) {
    const d = 0.008;
    return `https://www.openstreetmap.org/export/embed.html?bbox=${lon-d},${lat-d},${lon+d},${lat+d}&layer=mapnik&marker=${lat},${lon}`;
  }
  return 'https://www.openstreetmap.org/export/embed.html?bbox=110.30,-7.80,110.45,-7.65&layer=mapnik';
};

const submitForm = async () => {
  submitting.value = true;
  await store.addInbox({
    name: form.value.name,
    phone: form.value.phone,
    email: form.value.email,
    message: form.value.message
  });
  setTimeout(() => {
    submitting.value = false;
    toast.value = 'Pesan berhasil dikirim!';
    form.value = { name: '', phone: '', email: '', message: '' };
    setTimeout(() => toast.value = '', 3000);
  }, 500);
};

const handleImageError = (event) => {
  event.target.src = 'https://images.unsplash.com/photo-1500382017468-9049fed747ef?auto=format&fit=crop&w=1200&q=80';
};
</script>

<style scoped>
.fade-enter-active, .fade-leave-active { transition: opacity 0.25s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
</style>