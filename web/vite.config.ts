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
    coverage: {
      provider: 'v8',
      // The gate is the pure engine (the math ported bit-for-bit from BidLabCore).
      // Components are UI and covered separately; they are not part of this gate.
      include: ['src/engine/**/*.ts'],
      exclude: ['src/engine/**/*.test.ts'],
      reporter: ['text-summary', 'text'],
      thresholds: { statements: 100, branches: 100, functions: 100, lines: 100 },
    },
  },
})
