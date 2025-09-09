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
    <div class="bg" :style="{ backgroundImage: `url(${image})` }" />
  </a>
</template>

<script setup lang="ts">
defineProps<{
  title: string;
  eyebrow: string;
  description: string;
  href: string;
  image: string; // full URL or /assets/...
}>();
</script>

<style scoped>
.site-card {
  position: relative;
  display: grid;
  grid-template-rows: 1fr;
  border-radius: 22px;
  overflow: hidden;
  min-height: 280px;
  background: var(--card);
  border: 1px solid var(--stroke);
  transition: transform .35s cubic-bezier(.2,.8,.2,1), box-shadow .35s, border-color .35s;
  will-change: transform;
  isolation: isolate;
}
.site-card:hover { transform: translateY(-6px); border-color: transparent; box-shadow: 0 20px 40px rgba(2,6,23,.25); }

.bg {
  position: absolute; inset: 0;
  background-size: cover; background-position: center;
  transform: scale(1.02);
  transition: transform .6s ease, filter .6s ease, opacity .6s ease;
  opacity: .33;
  filter: saturate(1.02) contrast(1.02);
}
.site-card:hover .bg { transform: scale(1.06); filter: saturate(1.1) contrast(1.08); opacity: .42; }

.ring {
  position: absolute; inset: -1px; z-index: 1; pointer-events: none;
  background:
    radial-gradient(800px 300px at 0% 0%, var(--ring), transparent 36%),
    radial-gradient(800px 300px at 100% 100%, rgba(244,180,0,.15), transparent 36%);
}

.content {
  position: relative; z-index: 2; display: grid; gap: .6rem;
  padding: clamp(16px, 2.5vw, 22px); backdrop-filter: blur(6px);
}
.eyebrow { font-size: .8rem; letter-spacing: .08em; text-transform: uppercase; color: var(--brand-ink); font-weight: 800; }
.title { margin: 0; font-size: clamp(1.1rem, 1.05rem + 1vw, 1.7rem); line-height: 1.1; color: var(--ink); }
.desc { margin: 0; color: var(--muted); font-size: .98rem; line-height: 1.55; }
.cta {
  margin-top: .4rem; display: inline-flex; align-items: center; gap: .5rem; font-weight: 700;
  color: white; background: var(--brand-ink); padding: .55rem .8rem; border-radius: 999px;
  box-shadow: 0 8px 20px rgba(17,97,93,.22); transition: .25s transform, .25s box-shadow, .25s background;
}
.site-card:hover .cta { background: var(--brand); box-shadow: 0 10px 24px rgba(0,177,64,.25); transform: translateY(-1px); }
.site-card:focus-visible { outline: 3px solid var(--accent); outline-offset: 5px; border-radius: 24px; }

/* Small screens: keep cards airy and readable */
@media (max-width: 480px) {
  .desc { font-size: .95rem; }
  .cta { font-size: .92rem; }
}
</style>
