<template>
  <!-- Pass a hex like "#a12d35" or "#00b341"; we pipe it into CSS vars -->
  <section :id="id" class="site" :class="{ flip }" :style="accentStyle">
    <div class="shell">
      <div class="grid">
        <div class="copy">
          <p class="eyebrow">{{ eyebrow }}</p>
          <h3 class="title">{{ title }}</h3>
          <p class="lead">{{ description }}</p>

          <ul class="points">
            <li v-for="(p, i) in points" :key="i">{{ p }}</li>
          </ul>

          <div class="actions">
            <a :href="href" target="_blank" rel="noopener" class="btn btn--accent">
              Visit {{ ctaLabel || 'Site' }}
            </a>
            <a :href="href" target="_blank" rel="noopener" class="btn btn--ghost">
              Learn More
            </a>
          </div>
        </div>

        <div class="art">
          <div class="card">
            <img :src="image" :alt="alt" />
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { computed } from "vue";

const props = withDefaults(defineProps<{
  id?: string;
  eyebrow: string;
  title: string;
  description: string;
  points: string[];
  href: string;
  image: string;
  alt: string;
  ctaLabel?: string;
  flip?: boolean;
  accent?: string; // NEW: hex color per section, e.g. "#a12d35"
}>(), {
  accent: "var(--brand)", // fallback to your global brand green
});

const accentStyle = computed(() => ({
  // Main accent + a darker variant using color-mix (modern browsers)
  '--accent': props.accent,
  '--accent-dark': `color-mix(in srgb, ${props.accent} 82%, black)`,
  '--accent-wash-top': `color-mix(in srgb, ${props.accent} 8%, transparent)`,
  '--accent-wash-btm': `color-mix(in srgb, ${props.accent} 3%, transparent)`,
  '--accent-ring': `color-mix(in srgb, ${props.accent} 22%, transparent)`,
  '--accent-shadow': `color-mix(in srgb, ${props.accent} 28%, transparent)`,
}));
</script>

<style scoped>
.site{
  position: relative;
  padding: clamp(40px, 8vw, 90px) 0;
  background: linear-gradient(180deg, var(--accent-wash-top), var(--accent-wash-btm));
}
a {
  text-decoration: none;
}
.site::before{
  content:""; position:absolute; inset:0; z-index:-1; opacity:.06;
  background-image:url("data:image/svg+xml;utf8,\
<svg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24'>\
<rect width='100%' height='100%' fill='none'/>\
<circle cx='1' cy='1' r='1' fill='%23000000' fill-opacity='0.7'/>\
</svg>");
}
.shell{ width:min(1280px,92%); margin:0 auto; }

.grid{ display:grid; gap: clamp(18px, 3vw, 36px); grid-template-columns:1fr; align-items:center; }
@media (min-width:980px){
  .grid{ grid-template-columns:1.05fr 1fr; }
  .site.flip .grid{ grid-template-columns:1fr 1.05fr; }
  .site.flip .copy{ order:2; } .site.flip .art{ order:1; }
}

.copy{ max-width:720px; }
.eyebrow{
  color: var(--accent);
  font-weight:900; letter-spacing:.08em; text-transform:uppercase; margin:0 0 .5rem;
}
.title{ margin:0 0 .5rem; font-size: clamp(1.6rem, 1.2rem + 2vw, 2.2rem); color: var(--ink); }
.lead{ margin:0 0 1rem; color: var(--muted); line-height: 1.65; }

.points{ margin:.4rem 0 1.2rem; padding:0; list-style:none; display:grid; gap:.5rem; }
.points li{ padding-left:1.2rem; position:relative; color: var(--ink); }
.points li::before{
  content:""; position:absolute; left:0; top:.45rem; width:.6rem; height:.6rem; border-radius: 50%;
  background: var(--accent);
  box-shadow: 0 0 0 3px var(--accent-ring);
}

.actions{ display:flex; gap:.8rem; flex-wrap:wrap; }
.btn{
  display:inline-flex; align-items:center; gap:.5rem;
  padding:.8rem 1.15rem; border-radius:16px; font-weight:900; letter-spacing:.2px;
  border:1px solid transparent; transition:.25s transform, .25s box-shadow, .25s background, .25s color;
}
.btn--accent{
  background: linear-gradient(90deg, var(--accent), var(--accent-dark));
  color:#fff;
  box-shadow: 0 10px 24px var(--accent-shadow);
}
.btn--accent:hover{ transform: translateY(-2px); box-shadow: 0 14px 28px var(--accent-shadow); }
.btn--ghost{ background: transparent; color: var(--ink); border-color: var(--stroke); }
.btn--ghost:hover{ background: var(--card); }

.art .card{ border-radius: clamp(16px, 2vw, 22px); overflow:hidden; box-shadow: 0 24px 60px rgba(0,0,0,.18); }
.card img{ width:100%; height: clamp(260px, 40vw, 460px); object-fit: cover; }
</style>
