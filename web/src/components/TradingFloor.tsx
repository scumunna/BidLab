// The hero Trading Floor, ported from the native app's
// Sources/BidLab/Surfaces/TradingFloor/TradingFloorView.swift. Drag your bid,
// watch the analytic win rate and expected-profit curve respond, then run 50,000
// simulated auctions and score your strategy against the mathematical optimum.

import { useCallback, useMemo, useState } from 'react'
import {
  MarketConfig,
  type MarketResult,
  runMarket,
  Scoring,
  SCENARIOS,
  OPPORTUNITIES,
  SEED,
  BUDGET_CAP,
  scenarioValue,
  type Scenario,
} from '../engine'
import { intc, money, pct } from '../format'
import { ProfitCurve, type CurvePoint } from './ProfitCurve'

const C = {
  lime: '#b6ff3a',
  up: '#18c964',
  down: '#ff3b5c',
  analytics: '#00b4d8',
  white: '#f4f4f8',
}

function buildConfig(s: Scenario, floor: number, secondPrice: boolean, bid: number): MarketConfig {
  return new MarketConfig({
    opportunities: OPPORTUNITIES,
    bid,
    budget: BUDGET_CAP,
    marketMean: s.marketMean,
    floor,
    ctr: s.ctr,
    cvr: s.cvr,
    revenuePerConversion: s.revenuePerConversion,
    model: { kind: 'logNormal', sigma: s.marketSigma },
    auction: secondPrice ? 'secondPrice' : 'firstPrice',
  })
}

function Segmented<T extends string | number>({
  options,
  value,
  onChange,
  ariaLabel,
}: {
  options: { label: string; value: T }[]
  value: T
  onChange: (v: T) => void
  ariaLabel: string
}) {
  return (
    <div role="tablist" aria-label={ariaLabel} className="flex gap-1 rounded-full bg-white/5 p-1">
      {options.map((o) => {
        const active = o.value === value
        return (
          <button
            key={String(o.value)}
            role="tab"
            aria-selected={active}
            onClick={() => onChange(o.value)}
            className={`flex-1 rounded-full px-3 py-1.5 text-[12.5px] font-semibold transition-colors ${
              active ? 'bg-white/15 text-ink' : 'text-muted hover:text-ink'
            }`}
          >
            {o.label}
          </button>
        )
      })}
    </div>
  )
}

function Stat({ label, value, color = C.white }: { label: string; value: string; color?: string }) {
  return (
    <div className="flex flex-col gap-0.5">
      <span className="font-mono text-[10px] uppercase tracking-wide text-white/40">{label}</span>
      <span className="font-mono text-[15px] font-bold tabular-nums" style={{ color }}>
        {value}
      </span>
    </div>
  )
}

function Slider({
  label,
  value,
  min,
  max,
  step,
  display,
  color,
  onChange,
}: {
  label: string
  value: number
  min: number
  max: number
  step: number
  display: string
  color: string
  onChange: (v: number) => void
}) {
  return (
    <div className="flex flex-col gap-2">
      <div className="flex items-baseline justify-between">
        <span className="font-mono text-[10px] uppercase tracking-wide text-white/40">{label}</span>
        <span className="font-mono text-[15px] font-bold tabular-nums" style={{ color }}>
          {display}
        </span>
      </div>
      <input
        type="range"
        min={min}
        max={max}
        step={step}
        value={value}
        onChange={(e) => onChange(Number(e.target.value))}
        style={{ ['--thumb' as string]: color }}
        aria-label={label}
        aria-valuetext={display}
      />
    </div>
  )
}

const card = 'rounded-2xl border border-white/10 bg-white/[0.04] p-4'

export function TradingFloor() {
  const [scenarioIndex, setScenarioIndex] = useState(0)
  const [secondPrice, setSecondPrice] = useState(false)
  const s = SCENARIOS[scenarioIndex]
  const value = scenarioValue(s)
  const [bid, setBid] = useState(value * 0.3)
  const [floor, setFloor] = useState(s.floor)
  const [result, setResult] = useState<MarketResult | null>(null)
  const [scoreVal, setScoreVal] = useState<number | null>(null)

  const selectScenario = useCallback((i: number) => {
    const ns = SCENARIOS[i]
    setScenarioIndex(i)
    setBid(scenarioValue(ns) * 0.3)
    setFloor(ns.floor)
    setResult(null)
    setScoreVal(null)
  }, [])

  const selectAuction = useCallback((second: boolean) => {
    setSecondPrice(second)
    setResult(null)
    setScoreVal(null)
  }, [])

  // The curve, optimal bid, and floor depend on the scenario/auction/floor — NOT
  // on the slider bid — so they only recompute when those change (keeps dragging
  // the bid smooth even with the second-price integral).
  const cfg = useMemo(() => buildConfig(s, floor, secondPrice, value), [s, floor, secondPrice, value])
  const optimal = useMemo(() => cfg.optimal(), [cfg])
  const profitCurve = useMemo<CurvePoint[]>(() => {
    const n = 120
    return Array.from({ length: n + 1 }, (_, i) => {
      const b = (value * i) / n
      return { x: b, y: cfg.expectedProfitPerOpportunity(b) }
    })
  }, [cfg, value])

  const winRate = cfg.winProbability(bid)
  const expProfitPerOpp = cfg.expectedProfitPerOpportunity(bid)
  const belowFloor = bid < floor

  const run = useCallback(() => {
    const runCfg = buildConfig(s, floor, secondPrice, bid)
    const r = runMarket(runCfg, SEED)
    const sc = Scoring.score(r.profit / OPPORTUNITIES, optimal.expectedProfit)
    setResult(r)
    setScoreVal(sc)
  }, [s, floor, secondPrice, bid, optimal])

  const scoreColor = scoreVal == null ? C.white : scoreVal >= 80 ? C.up : scoreVal >= 50 ? C.lime : C.down

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      {/* top bar */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <span className="inline-block h-2 w-2 rounded-full bg-up" />
          <span className="font-mono text-[11px] font-semibold text-up">MARKET OPEN</span>
        </div>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">
          scenario · {s.name.toLowerCase()} · {secondPrice ? 'second-price' : 'first-price'}
        </span>
      </div>

      {/* header */}
      <div className="mt-4 flex flex-col gap-1">
        <h2 className="text-2xl font-extrabold tracking-tight sm:text-3xl">Trading Floor</h2>
        <p className="text-[13.5px] text-white/60">Set your bid, then run the market. Score against the optimal strategy.</p>
      </div>

      {/* pickers */}
      <div className="mt-4 flex flex-col gap-3 lg:flex-row">
        <div className="lg:max-w-[480px] lg:flex-1">
          <Segmented
            ariaLabel="Scenario"
            value={scenarioIndex}
            onChange={selectScenario}
            options={SCENARIOS.map((sc, i) => ({ label: sc.name, value: i }))}
          />
        </div>
        <div className="lg:w-[240px]">
          <Segmented
            ariaLabel="Auction type"
            value={secondPrice ? 1 : 0}
            onChange={(v) => selectAuction(v === 1)}
            options={[
              { label: 'First price', value: 0 },
              { label: 'Second price', value: 1 },
            ]}
          />
        </div>
      </div>

      {/* body */}
      <div className="mt-5 grid grid-cols-1 gap-5 lg:grid-cols-[360px_1fr]">
        {/* control panel */}
        <div className="flex flex-col gap-4">
          <div className={card}>
            <div className="font-mono text-[10px] uppercase tracking-wide text-white/40">Scenario</div>
            <div className="mt-2 flex gap-5">
              <Stat label="Value / imp" value={money(value, 2)} color={C.lime} />
              <Stat label="Market mean" value={money(s.marketMean, 2)} color={C.analytics} />
            </div>
            <div className="mt-3 flex gap-5">
              <Stat label="CTR" value={pct(s.ctr)} />
              <Stat label="CVR" value={pct(s.cvr)} />
              <Stat label="Rev / conv" value={money(s.revenuePerConversion, 0)} />
            </div>
          </div>

          <div className={`${card} flex flex-col gap-3`}>
            <Slider
              label="Your bid"
              value={bid}
              min={0.001}
              max={value}
              step={value / 1000}
              display={money(bid, 3)}
              color={C.lime}
              onChange={setBid}
            />
            <Slider
              label="Publisher floor"
              value={floor}
              min={0}
              max={value}
              step={value / 1000}
              display={money(floor, 3)}
              color={C.down}
              onChange={setFloor}
            />
            {belowFloor && (
              <p className="text-[11.5px] font-medium text-down">Your bid is under the floor, so it never clears the reserve.</p>
            )}
            <div className="flex gap-5">
              <Stat label="Win rate" value={pct(winRate)} color={C.lime} />
              <Stat label="Exp. profit / 1k" value={money(expProfitPerOpp * 1000, 2)} color={C.up} />
            </div>
            <button
              onClick={run}
              className="mt-1 flex items-center justify-center gap-2 rounded-full bg-lime py-2.5 font-semibold text-console transition-transform active:scale-[0.98]"
            >
              <span aria-hidden>▶</span>
              Run {intc(OPPORTUNITIES)} auctions
            </button>
          </div>

          {result && scoreVal != null ? (
            <div className={card}>
              <div className="flex items-center justify-between">
                <span className="font-mono text-[10px] uppercase tracking-wide text-white/40">Your score</span>
                <span className="font-mono text-[11px] text-analytics">optimal bid {money(optimal.bid, 3)}</span>
              </div>
              <div className="font-mono text-5xl font-extrabold tabular-nums" style={{ color: scoreColor }}>
                {scoreVal.toFixed(0)}
              </div>
              <div className="mt-3 grid grid-cols-2 gap-3">
                <Stat label="Impressions" value={intc(result.impressionsWon)} />
                <Stat label="Spend" value={money(result.spend, 0)} />
                <Stat label="Conversions" value={intc(result.conversions)} />
                <Stat label="eff. CPA" value={result.conversions > 0 ? money(result.effectiveCPA, 2) : '—'} />
                <Stat label="Revenue" value={money(result.revenue, 0)} color={C.up} />
                <Stat label="Profit" value={money(result.profit, 0)} color={result.profit >= 0 ? C.up : C.down} />
                <Stat label="Below floor" value={pct(result.lostToFloorRate)} color={C.down} />
                <Stat label="Outbid" value={pct(result.lostToCompetitionRate)} />
              </div>
            </div>
          ) : (
            <p className="px-1 text-[12.5px] text-white/45">Run the market to see realized results and your score.</p>
          )}
        </div>

        {/* chart panel */}
        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          <div className="flex flex-wrap gap-x-4 gap-y-1">
            <Legend color={C.lime} label="expected profit" />
            <Legend color={C.lime} label="your bid" />
            <Legend color={C.down} label="floor" />
            <Legend color={C.analytics} label="optimal" />
          </div>
          <div className="mt-3">
            <ProfitCurve
              points={profitCurve}
              xMax={value}
              yMax={Math.max(optimal.expectedProfit * 1.2, 1e-4)}
              bid={bid}
              floor={floor}
              optimalBid={optimal.bid}
              optimalProfit={optimal.expectedProfit}
            />
          </div>
          <div className="mt-1 flex justify-between font-mono text-[10px] text-white/40">
            <span>bid → {money(0, 0)}</span>
            <span>{money(value, 2)}</span>
          </div>
        </div>
      </div>

      {/* transparency footer */}
      <div className="mt-5 rounded-2xl border border-analytics/20 bg-analytics/[0.04] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-analytics">Open the hood</div>
        <p className="mt-2 font-mono text-[13px] text-white/80">
          {secondPrice ? 'E[π / opp] = ∫ (value − c) · f(c) dc' : 'E[π / opp] = P_win(bid) · (value − bid)'}
        </p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>
            Competing clearing price is log-normal with mean {money(s.marketMean, 2)} and log spread σ = {s.marketSigma.toFixed(2)}, so
            the win curve is the log-normal CDF — the S-shaped bid landscape.
          </li>
          <li>Value per impression = CTR × CVR × revenue per conversion.</li>
          <li>
            {secondPrice
              ? 'Second-price clearing: the winner pays max(clearing price, floor), so bidding true value is optimal.'
              : 'First-price clearing: the winner pays its own bid, so the optimal bid shades below value.'}
          </li>
          <li>Publisher floor {money(floor, 2)} is the reserve: a bid below it never clears.</li>
        </ul>
        <div className="mt-3 grid grid-cols-2 gap-x-6 gap-y-1.5 sm:grid-cols-4">
          <Param label="your bid" value={money(bid, 3)} />
          <Param label="market mean" value={money(s.marketMean, 2)} />
          <Param label="market sigma" value={s.marketSigma.toFixed(2)} />
          <Param label="value / imp" value={money(value, 2)} />
          <Param label="analytic win rate" value={pct(winRate)} />
          <Param label="optimal bid" value={money(optimal.bid, 3)} />
          <Param label="opportunities" value={intc(OPPORTUNITIES)} />
          <Param label="rng seed" value={SEED.toString()} />
        </div>
      </div>
    </section>
  )
}

function Legend({ color, label }: { color: string; label: string }) {
  return (
    <span className="flex items-center gap-1.5">
      <span className="inline-block h-[7px] w-[7px] rounded-full" style={{ backgroundColor: color }} />
      <span className="font-mono text-[10px] text-white/55">{label}</span>
    </span>
  )
}

function Param({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex items-baseline justify-between gap-2 border-b border-white/5 pb-1">
      <span className="font-mono text-[10px] text-white/40">{label}</span>
      <span className="font-mono text-[11px] font-semibold tabular-nums text-white/80">{value}</span>
    </div>
  )
}
