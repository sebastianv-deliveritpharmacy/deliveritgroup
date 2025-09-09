<template>
  <div
    ref="el"
    class="reveal"
    :style="{ '--delay': delay }"
    :class="{ 'is-visible': visible, 'is-enhanced': enhanced }"
  >
    <slot />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onBeforeUnmount } from 'vue';

const props = withDefaults(defineProps<{ delay?: string; once?: boolean }>(), {
  delay: '0s',
  once: true,
});

const el = ref<HTMLElement | null>(null);
const visible = ref(false);
const enhanced = ref(false);
let obs: IntersectionObserver | null = null;

onMounted(() => {
  enhanced.value = true; // mark that JS is active
  obs = new IntersectionObserver(
    (entries) => {
      entries.forEach((e) => {
        if (e.isIntersecting) {
          visible.value = true;
          if (props.once) obs?.disconnect();
        } else if (!props.once) {
          visible.value = false;
        }
      });
    },
    { threshold: 0.15 }
  );
  if (el.value) obs.observe(el.value);
});

onBeforeUnmount(() => obs?.disconnect());
</script>

<style scoped>
/* Default: visible (SSR/no-JS safe) */
.reveal { opacity: 1; transform: none; }

/* When hydrated, start hidden and animate in */
.is-enhanced { opacity: 0; transform: translateY(12px);
  transition: opacity .6s ease var(--delay), transform .6s ease var(--delay);
}
.is-enhanced.is-visible { opacity: 1; transform: translateY(0); }
</style>
