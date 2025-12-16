<template>
  <section class="hero" id="home">
    <Swiper
      class="hero-swiper"
      :modules="modules"
      :slides-per-view="1"
      :loop="true"
      :speed="1900"
      :autoplay="{ delay: 4200, disableOnInteraction: false }"
      :effect="'fade'"
      :fadeEffect="{ crossFade: true }"
      :navigation="true"
      :pagination="{ clickable: true }"
      :parallax="true"
      @slideChangeTransitionStart="onSlideStart"
      @slideChangeTransitionEnd="onSlideEnd"
    >
      <SwiperSlide v-for="s in slides" :key="s.href">
        <div class="shell">
          <div class="slide">
            <!-- Left content -->
            <div class="copy" :data-animate="animating ? 'out' : 'in'">
              <p class="eyebrow" :style="{ color: s.eyebrowColor || 'var(--berry)' }">
                {{ s.eyebrow }}
              </p>
              <h1 class="headline" data-swiper-parallax="-120">
                {{ s.title }}
              </h1>
              <p class="lead" data-swiper-parallax="-80">
                {{ s.description }}
              </p>

              <div class="actions" data-swiper-parallax="-60">
                <a :href="s.href" class="btn btn--brand" target="_blank" rel="noopener">
                  Visit Site
                </a>
                <a :href="s.secondaryHref || s.href" class="btn btn--ghost" target="_blank" rel="noopener">
                  Learn More
                </a>
              </div>
            </div>

            <!-- Right image -->
            <div class="art">
              <img :src="s.image" :alt="s.alt" class="photo" />
              <div class="blob blob--green" />
              <div class="blob blob--red" />
            </div>
          </div>
        </div>
      </SwiperSlide>

      <!-- Swiper chrome -->
      <div class="swiper-pagination" />
    </Swiper>
  </section>
</template>

<script setup lang="ts">
import { ref } from "vue";
import { Swiper, SwiperSlide } from "swiper/vue";
import { Autoplay, Navigation, Pagination, EffectFade, Parallax } from "swiper/modules";

import "swiper/css";
import "swiper/css/navigation";
import "swiper/css/pagination";
import "swiper/css/effect-fade";

const modules = [Autoplay, Navigation, Pagination, EffectFade, Parallax];
const animating = ref(false);

const slides = [
  {
    eyebrow: "Specialty Infusion",
    eyebrowColor: "var(--berry)",
    title: "DeliverIt Infusion & Specialty",
    description:
      "Experience our warm, private infusion suites coupled with expert care. Learn more about referral forms, insurance, and training resources.",
    href: "https://deliveritpharmacy.com/infusion/",
    image: "/images/infusion-hero.jpg",
    alt: "Infusion care"
  },
  {
    eyebrow: "Retail & Family Care",
    eyebrowColor: "var(--brand)",
    title: "DeliverIt Retail Pharmacy",
    description:
      "Local prescriptions, vaccinations, compounding, and home delivery — for the whole family.",
    href: "https://deliveritpharmacy.com/retail/",
    image: "/images/retail-hero.jpg",
    alt: "Retail pharmacy"
  },
  {
    eyebrow: "Telehealth",
    eyebrowColor: "var(--brand)",
    title: "DeliverIt Health",
    description:
      "Chat online with doctors via phone call or video. Discover convenient family coverage for your next digital prescription.",
    href: "https://deliverithealth.com/",
    image: "/images/telehealth-hero.jpg",
    alt: "Telehealth consultation"
  },
  {
    eyebrow: "RAD",
    eyebrowColor: "#008c95",
    title: "DeliverIt Research & Develpoment",
    description:
      "DeliverIt RAD partners with leading U.S. multinational companies to accelerate research and development of new medications, with a focus on oncology, cardiology, and neurology.",
    href: "#",
    image: "/images/rd-hero.jpg",
    alt: "DeliverIt Research & Develpoment"
  },  
  {
    eyebrow: "International Training",
    eyebrowColor: "#3467c7", // brand blue
    title: "GCC Service Training Program",
    description:
      "On-site & virtual training for partners across Saudi Arabia, UAE, Qatar, Kuwait, Bahrain, and Oman — SOP onboarding, device teach-backs, QA/compounding standards, and bilingual materials (EN/AR).",
    href: "/#gccTraining",                // replace with your training/partners URL when ready
    secondaryHref: "/#gccTraining",       // optional: link to a PDF/Deck or contact page
    image: "/images/gcc-training-hero.jpg",
    alt: "GCC international service training across KSA, UAE, Qatar, Kuwait, Bahrain, and Oman"
  },
];

function onSlideStart() { animating.value = true; }
function onSlideEnd() { animating.value = false; }
</script>

<style scoped>
/* Brand tokens already set globally; repeating key ones for clarity */
:root{
  --brand:#36aa67;      /* primary green */
  --brand-dark:#2f8f57;
  --berry:#a12d35;      /* deep red */
  --ink:#0b1320;
  --muted:#5b6677;
  --bg:#f7faf8;
  --card: rgba(0,0,0,.04);
  --stroke: rgba(0,0,0,.08);
}

.hero { position: relative; background: #fff; }

a {
    text-decoration: none;
}

/* Centered inner container with max width */
.shell {
  width: min(1280px, 92%);
  margin: 0 auto;
}

/* Slide layout */
.slide {
  display: grid;
  grid-template-columns: 1fr;
  align-items: center;
  gap: clamp(18px, 3vw, 36px);
  padding: clamp(28px, 6vw, 72px) 0; /* no horizontal padding; shell handles it */
  min-height: min(86vh, 860px);
}
@media (min-width: 960px) {
  .slide { grid-template-columns: 1.05fr 1fr; }
}

/* Copy */
.copy { max-width: 720px; }
.eyebrow { font-weight: 800; letter-spacing: .08em; text-transform: uppercase; margin: 0 0 .5rem; }
.headline { margin: 0 0 .6rem; font-size: clamp(2rem, 3.6vw + 1rem, 3.4rem); line-height: 1.08; color: var(--ink); }
.lead { margin: 0 0 1.1rem; color: var(--muted); font-size: clamp(1rem, .6vw + 1rem, 1.15rem); line-height: 1.6; }

/* CTA Buttons */
.actions { display: flex; gap: .8rem; flex-wrap: wrap; }
.btn {
  display:inline-flex; align-items:center; gap:.5rem;
  padding:.85rem 1.15rem; border-radius:16px; font-weight:800; letter-spacing:.2px;
  border:1px solid transparent; transition:.25s transform, .25s box-shadow, .25s background, .25s color;
}
.btn--brand { background: linear-gradient(90deg, var(--brand), var(--brand-dark)); color:  #2f8f57; box-shadow: 0 10px 24px rgba(54,170,103,.28); }
.btn--brand:hover { transform: translateY(-2px); box-shadow: 0 14px 28px rgba(54,170,103,.35); }
.btn--ghost { background: transparent; color: var(--ink); border-color: var(--stroke); }
.btn--ghost:hover { background: var(--card); }

/* Art (right) */
.art { position: relative; min-height: 320px; }
.photo {
  width: 100%; height: clamp(280px, 48vw, 560px);
  object-fit: cover; object-position: center;
  border-radius: clamp(16px, 2vw, 26px);
  box-shadow: 0 20px 48px rgba(0,0,0,.22);
  transform: translateZ(0);
}

/* Brand blobs */
.blob { position: absolute; border-radius: 50%; filter: blur(38px); opacity: .35; pointer-events: none; animation: float 18s ease-in-out infinite; }
.blob--green { width: 34vmin; height: 34vmin; left: -6vmin; top: -6vmin; background: radial-gradient(circle at 30% 30%, rgba(54,170,103,.38), transparent 60%); }
.blob--red { width: 38vmin; height: 38vmin; right: -6vmin; bottom: -8vmin; background: radial-gradient(circle at 70% 70%, rgba(161,45,53,.30), transparent 60%); animation-delay: -6s; }
@keyframes float { 0%,100%{ transform: translate3d(0,0,0);} 50%{ transform: translate3d(1.6vmin,-1.6vmin,0);} }

/* Swiper chrome */
.hero-swiper { --swiper-navigation-size: 22px; position: relative; }

/* Keep arrows OUTSIDE the shell so they never overlap text/image */
:deep(.swiper-button-prev),
:deep(.swiper-button-next) {
  color: #0f2540;
  width: 42px; height: 42px; border-radius: 50%;
  background: rgba(255,255,255,.95);
  box-shadow: 0 8px 20px rgba(0,0,0,.15);
  top: 50%;
  transform: translateY(-50%);
  z-index: 2;
}

/* Calculate arrow position relative to centered shell */
:deep(.swiper-button-prev) {
  /* place just outside shell's left edge */
  left: calc(48% - min(640px, 46%) - 26px);
}
:deep(.swiper-button-next) {
  /* place just outside shell's right edge */
  right: calc(48% - min(640px, 46%) - 26px);
}

:deep(.swiper-button-prev:hover),
:deep(.swiper-button-next:hover) { background: #fff; transform: translateY(-50%) translateX(0) scale(1.02); }

:deep(.swiper-pagination-bullet) { background: #0f2540; opacity: .35; }
:deep(.swiper-pagination-bullet-active) { background: var(--brand); opacity: 1; }

/* Text micro-animations */
.copy[data-animate="in"] { opacity: 1; transform: translateY(0); transition: opacity .5s ease, transform .5s ease; }
.copy[data-animate="out"] { opacity: 0; transform: translateY(8px); transition: opacity .35s ease, transform .35s ease; }

/* On very small screens, keep arrows close to edges */
@media (max-width: 1409px) {
  :deep(.swiper-button-prev) { display: none;}
  :deep(.swiper-button-next) { display: none; }
}
</style>
