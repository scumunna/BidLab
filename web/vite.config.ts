import { defineConfig } from 'vitest/config'
import react from '@vitejs/plugin-react'
import tailwindcss from '@tailwindcss/vite'

// GitHub Pages serves this project from the `/BidLab/` sub-path
// (https://scumunna.github.io/BidLab/), so the asset base must match.
export default defineConfig({
  base: '/BidLab/',
  plugins: [react(), tailwindcss()],
  test: {
    environment: 'node',
    include: ['src/**/*.test.ts'],
  },
})
