<template>
  <a
    class="site-card"
    :href="href"
    target="_blank"
    rel="noopener"
    :aria-label="`Open ${title}`"
  >
    <div class="ring" />

    <div class="content">
      <div class="eyebrow">{{ eyebrow }}</div>
      <h3 class="title">{{ title }}</h3>
      <p class="desc">{{ description }}</p>
      <div class="cta">
        <span>Visit</span>
        <svg width="18" height="18" viewBox="0 0 24 24" aria-hidden="true">
          <path fill="currentColor" d="M14 3h7v7h-2V6.41l-9.29 9.3-1.42-1.42 9.3-9.29H14V3Z" />
          <path fill="currentColor" d="M5 5h5V3H3v7h2V5Z" opacity=".5" />
        </svg>
      </div>
    </div>

    <!-- image card -->
    <div class="media">
      <img :src="image" :alt="`${title} preview`" loading="lazy" />
    </div>

    <div class="blob blob--green"></div>
    <div class="blob blob--red"></div>
  </a>
</template>

<script setup lang="ts">
defineProps<{
  title: string;
  eyebrow: string;
  description: string;
  href: string;
  image: string;
}>();
</script>

<style scoped>
/* remove any legacy bg layer */
.bg { display: none !important; }

/* card layout */
.site-card{
  position: relative;
  display: grid;
  grid-template-columns: 1fr;           /* mobile: stack */
  gap: clamp(14px, 2.6vw, 22px);
  align-items: center;
  padding: clamp(14px, 2.4vw, 22px);
  border-radius: 22px;
  background: var(--card);
  border: 1px solid var(--stroke);
  overflow: hidden;
  transition: transform .35s cubic-bezier(.2,.8,.2,1), box-shadow .35s, border-color .35s;
}
@media (min-width: 880px){
  .site-card{ grid-template-columns: 1.05fr 1fr; min-height: 320px; }
}
.site-card:hover{ transform: translateY(-6px); border-color: transparent; box-shadow: 0 20px 40px rgba(2,6,23,.18); }

/* glow ring */
.ring{
  position:absolute; inset:-1px; z-index:1; pointer-events:none;
  background:
    radial-gradient(800px 300px at 0% 0%, var(--ring), transparent 36%),
    radial-gradient(800px 300px at 100% 100%, rgba(244,180,0,.15), transparent 36%);
}

/* text */
.content{ position:relative; z-index:2; display:grid; gap:.6rem; }
.eyebrow{ font-size:.8rem; letter-spacing:.08em; text-transform:uppercase; color:var(--brand-ink); font-weight:800; }
.title{ margin:0; font-size:clamp(1.1rem, 1.05rem + 1vw, 1.7rem); line-height:1.1; color:var(--ink); }
.desc{ margin:0; color:var(--muted); font-size:.98rem; line-height:1.55; }
.cta{
  margin-top:.4rem; display:inline-flex; align-items:center; gap:.5rem; font-weight:700;
  color:#fff; background:var(--brand-ink); padding:.55rem .8rem; border-radius:999px;
  box-shadow:0 8px 20px rgba(17,97,93,.22); transition:.25s transform,.25s box-shadow,.25s background;
}
.site-card:hover .cta{ background:var(--brand); box-shadow:0 10px 24px rgba(0,177,64,.25); transform:translateY(-1px); }
.site-card:focus-visible{ outline:3px solid var(--accent); outline-offset:5px; border-radius:24px; }

/* image card (like GroupIntro) */
.media{
  position:relative;
  justify-self:end;
  width: min(520px, 48%);               /* prevents full fill */
  aspect-ratio: 4 / 3;                   /* consistent shape */
  border-radius: clamp(14px, 2vw, 20px);
  overflow:hidden;
  box-shadow:0 18px 44px rgba(0,0,0,.18);
  background:#e8eef0;
}
.media img{
  width:100%; height:100%;
  display:block;
  object-fit:cover; object-position:center;
  transform: translateZ(0);
  transition: transform .6s ease;
}
.site-card:hover .media img{ transform: scale(1.04); }

/* blobs */
.blob{ position:absolute; border-radius:50%; filter:blur(36px); opacity:.24; pointer-events:none; z-index:0; }
.blob--green{ width:28vmin; height:28vmin; left:-6vmin; top:-6vmin; background:radial-gradient(circle at 30% 30%, rgba(54,170,103,.35), transparent 60%); }
.blob--red{ width:32vmin; height:32vmin; right:-6vmin; bottom:-8vmin; background:radial-gradient(circle at 70% 70%, rgba(161,45,53,.26), transparent 60%); }

/* mobile order */
@media (max-width: 879px){
  .media{ order:2; width:100%; }
  .content{ order:1; }
  .desc{ font-size:.95rem; }
  .cta{ font-size:.92rem; }
}
</style>
