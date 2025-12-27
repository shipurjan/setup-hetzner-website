// @ts-check
import { defineConfig } from 'astro/config';
import tailwindcss from '@tailwindcss/vite';
import compressor from 'astro-compressor';

// https://astro.build/config
export default defineConfig({
  site: process.env.DOMAIN ? `https://${process.env.DOMAIN}` : undefined,
  integrations: [compressor()],
  vite: {
    plugins: [tailwindcss()]
  },
  devToolbar: {
    enabled: false
  }
});
