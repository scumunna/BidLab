import { useEffect, useState } from 'react'
import { TradingFloor } from './components/TradingFloor'
import { ReachFrequency } from './components/ReachFrequency'
import { ABPower } from './components/ABPower'
import { BudgetAllocator } from './components/BudgetAllocator'
import { Latency } from './components/Latency'
import { Margin } from './components/Margin'
import { Attribution } from './components/Attribution'
import { Forecast } from './components/Forecast'
import { Yield } from './components/Yield'
import { PricingCalculator } from './components/PricingCalculator'
import { Adstock } from './components/Adstock'
import { Distribution } from './components/Distribution'
import { PixelSetup } from './components/PixelSetup'

const REPO = 'https://github.com/scumunna/BidLab'
const RELEASES = 'https://github.com/scumunna/BidLab/releases'

type RouteKey =
  | 'trading'
  | 'reach'
  | 'power'
  | 'budget'
  | 'latency'
  | 'margin'
  | 'attribution'
  | 'forecast'
  | 'yield'
  | 'pricing'
  | 'adstock'
  | 'distribution'
  | 'pixel'

const NAV: { key: RouteKey; label: string; href: string; title: string }[] = [
  { key: 'trading', label: 'Trading Floor', href: '#/', title: 'Trading Floor' },
  { key: 'reach', label: 'Reach & Frequency', href: '#/reach', title: 'Reach & Frequency' },
  { key: 'power', label: 'A/B Power', href: '#/power', title: 'A/B Test Power' },
  { key: 'budget', label: 'Budget Allocator', href: '#/budget', title: 'Budget Allocator' },
  { key: 'latency', label: 'Latency', href: '#/latency', title: 'Latency & Timeout' },
  { key: 'margin', label: 'Margin', href: '#/margin', title: 'Margin & Supply Path' },
  { key: 'pixel', label: 'Pixel Setup', href: '#/pixel', title: 'Pixel Setup' },
  { key: 'attribution', label: 'Attribution', href: '#/attribution', title: 'Attribution' },
  { key: 'forecast', label: 'Forecast', href: '#/forecast', title: 'Forecast' },
  { key: 'yield', label: 'Yield', href: '#/yield', title: 'Yield & Floors' },
  { key: 'pricing', label: 'Pricing', href: '#/pricing', title: 'Pricing Calculator' },
  { key: 'adstock', label: 'Adstock', href: '#/adstock', title: 'Adstock' },
  { key: 'distribution', label: 'Distribution', href: '#/distribution', title: 'Normal Distribution' },
]

function routeFromHash(): RouteKey {
  const h = window.location.hash
  const key = h.replace(/^#\//, '') as RouteKey
  return NAV.some((n) => n.key === key) ? key : 'trading'
}

export default function App() {
  const [route, setRoute] = useState<RouteKey>(routeFromHash)

  useEffect(() => {
    const onHash = () => {
      setRoute(routeFromHash())
      window.scrollTo({ top: 0 })
    }
    window.addEventListener('hashchange', onHash)
    return () => window.removeEventListener('hashchange', onHash)
  }, [])

  useEffect(() => {
    const nav = NAV.find((n) => n.key === route)
    document.title = `BidLab · ${nav?.title ?? 'Trading Floor'} — interactive programmatic demo`
  }, [route])

  return (
    <div className="mx-auto flex min-h-full max-w-5xl flex-col px-4 py-6 sm:px-6 sm:py-10">
      <header className="flex flex-col gap-4">
        <div className="flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div className="flex flex-col gap-1.5">
            <div className="flex items-center gap-2.5">
              <span className="grid h-8 w-8 place-items-center rounded-lg bg-lime font-extrabold text-console">B</span>
              <span className="text-lg font-extrabold tracking-tight">BidLab</span>
              <span className="rounded-full border border-white/10 px-2 py-0.5 font-mono text-[10px] uppercase tracking-wide text-white/45">
                interactive demos
              </span>
            </div>
            <p className="max-w-xl text-[13.5px] text-white/55">
              The flight simulator for programmatic advertising. These are live, math-true explorables — the actual BidLab engine,
              running in your browser.
            </p>
          </div>
          <div className="flex shrink-0 gap-2">
            <a
              href={RELEASES}
              target="_blank"
              rel="noopener noreferrer"
              className="rounded-full bg-lime px-4 py-2 text-[13px] font-semibold text-console transition-transform active:scale-[0.98]"
            >
              Get the macOS app
            </a>
            <a
              href={REPO}
              target="_blank"
              rel="noopener noreferrer"
              className="rounded-full border border-white/15 px-4 py-2 text-[13px] font-semibold text-white/80 transition-colors hover:bg-white/5"
            >
              View on GitHub
            </a>
          </div>
        </div>

        <nav className="flex flex-wrap gap-1.5" aria-label="Explorables">
          {NAV.map((n) => {
            const active = n.key === route
            return (
              <a
                key={n.key}
                href={n.href}
                aria-current={active ? 'page' : undefined}
                className={`rounded-full px-3.5 py-1.5 text-[13px] font-semibold transition-colors ${
                  active ? 'bg-white/15 text-ink' : 'text-muted hover:bg-white/5 hover:text-ink'
                }`}
              >
                {n.label}
              </a>
            )
          })}
        </nav>
      </header>

      <main className="mt-6">
        {route === 'trading' && <TradingFloor />}
        {route === 'reach' && <ReachFrequency />}
        {route === 'power' && <ABPower />}
        {route === 'budget' && <BudgetAllocator />}
        {route === 'latency' && <Latency />}
        {route === 'margin' && <Margin />}
        {route === 'attribution' && <Attribution />}
        {route === 'forecast' && <Forecast />}
        {route === 'yield' && <Yield />}
        {route === 'pricing' && <PricingCalculator />}
        {route === 'adstock' && <Adstock />}
        {route === 'distribution' && <Distribution />}
        {route === 'pixel' && <PixelSetup />}
      </main>

      <footer className="mt-8 border-t border-white/10 pt-6 text-[12.5px] leading-relaxed text-white/45">
        <p>
          <strong className="text-white/70">Why the numbers are real.</strong> Every explorable here runs a faithful TypeScript port
          of BidLab's pure Swift engine — the same auction model, reach/frequency Poisson math, and experiment-power formulas as the
          native macOS app. The ports are verified against the Swift engine in golden-master tests (the Trading Floor's seeded run
          matches the native app bit-for-bit).
        </p>
        <p className="mt-3">
          The full app adds 124 interactive lessons across 9 roles and 11 industry verticals, certification exams, spaced-repetition
          review, and shareable credentials.{' '}
          <a href={REPO} target="_blank" rel="noopener noreferrer" className="text-analytics underline-offset-2 hover:underline">
            See the project on GitHub →
          </a>
        </p>
      </footer>
    </div>
  )
}
