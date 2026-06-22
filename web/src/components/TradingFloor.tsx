// The hero Trading Floor, ported from the native app's
// Sources/BidLab/Surfaces/TradingFloor/TradingFloorView.swift. Drag your bid,
// watch the analytic win rate and expected-profit curve respond, then run 50,000
// simulated auctions (one-shot) or a budget-paced flight, and score against the
// mathematical optimum.

import { useCallback, useMemo, useState } from 'react'
import {
  MarketConfig,
  type MarketResult,
  runMarket,
  runPacedFlight,
  type PacedFlightResult,
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
import { LineChart } from './LineChart'
import { C, card, Legend, Segmented, Slider, Stat } from './ui'

const FLIGHT_INTERVALS = 12
const flightBudgetFor = (value: number) => value * OPPORTUNITIES * 0.15

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

export function TradingFloor() {
  const [scenarioIndex, setScenarioIndex] = useState(0)
  const [secondPrice, setSecondPrice] = useState(false)
  const [paced, setPaced] = useState(false)
  const s = SCENARIOS[scenarioIndex]
  const value = scenarioValue(s)
  const [bid, setBid] = useState(value * 0.3)
  const [floor, setFloor] = useState(s.floor)
  const [flightBudget, setFlightBudget] = useState(() => flightBudgetFor(scenarioValue(SCENARIOS[0])))
  const [result, setResult] = useState<MarketResult | null>(null)
  const [scoreVal, setScoreVal] = useState<number | null>(null)
  const [pacedResult, setPacedResult] = useState<PacedFlightResult | null>(null)

  const maxFlightBudget = Math.max(value * OPPORTUNITIES * 0.5, 100)

  const reset = () => {
    setResult(null)
    setScoreVal(null)
    setPacedResult(null)
  }

  const selectScenario = useCallback((i: number) => {
    const ns = SCENARIOS[i]
    setScenarioIndex(i)
    setBid(scenarioValue(ns) * 0.3)
    setFloor(ns.floor)
    setFlightBudget(flightBudgetFor(scenarioValue(ns)))
    reset()
  }, [])

  const selectAuction = useCallback((second: boolean) => {
    setSecondPrice(second)
    reset()
  }, [])

  const selectMode = useCallback((isPaced: boolean) => {
    setPaced(isPaced)
    reset()
  }, [])

  // The curve, optimal bid, and floor depend on the scenario/auction/floor — NOT
  // the slider bid — so they only recompute when those change.
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
    if (paced) {
      setPacedResult(runPacedFlight(buildConfig(s, floor, secondPrice, bid), flightBudget, FLIGHT_INTERVALS, SEED))
      setResult(null)
      setScoreVal(null)
      return
    }
    const r = runMarket(buildConfig(s, floor, secondPrice, bid), SEED)
    setResult(r)
    setScoreVal(Scoring.score(r.profit / OPPORTUNITIES, optimal.expectedProfit))
    setPacedResult(null)
  }, [paced, s, floor, secondPrice, bid, flightBudget, optimal])

  const scoreColor = scoreVal == null ? C.white : scoreVal >= 80 ? C.up : scoreVal >= 50 ? C.lime : C.down

  return (
    <section className="rounded-[22px] border border-white/10 bg-white/[0.02] p-5 sm:p-7">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <span className="inline-block h-2 w-2 rounded-full bg-up" />
          <span className="font-mono text-[11px] font-semibold text-up">MARKET OPEN</span>
        </div>
        <span className="hidden font-mono text-[11px] text-white/40 sm:block">
          scenario · {s.name.toLowerCase()} · {secondPrice ? 'second-price' : 'first-price'}
        </span>
      </div>

      <div className="mt-4 flex flex-col gap-1">
        <h2 className="text-2xl font-extrabold tracking-tight sm:text-3xl">Trading Floor</h2>
        <p className="text-[13.5px] text-white/60">Set your bid, then run the market. Score against the optimal strategy.</p>
      </div>

      <div className="mt-4 flex flex-col gap-3 lg:flex-row">
        <div className="lg:max-w-[480px] lg:flex-1">
          <Segmented ariaLabel="Scenario" value={scenarioIndex} onChange={selectScenario} options={SCENARIOS.map((sc, i) => ({ label: sc.name, value: i }))} />
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

      <div className="mt-5 grid grid-cols-1 gap-5 lg:grid-cols-[360px_1fr]">
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
            <Slider label="Your bid" value={bid} min={0.001} max={value} step={value / 1000} display={money(bid, 3)} color={C.lime} onChange={setBid} />
            <Slider label="Publisher floor" value={floor} min={0} max={value} step={value / 1000} display={money(floor, 3)} color={C.down} onChange={setFloor} />
            {belowFloor && <p className="text-[11.5px] font-medium text-down">Your bid is under the floor, so it never clears the reserve.</p>}
            <div className="flex gap-5">
              <Stat label="Win rate" value={pct(winRate)} color={C.lime} />
              <Stat label="Exp. profit / 1k" value={money(expProfitPerOpp * 1000, 2)} color={C.up} />
            </div>
            <Segmented
              ariaLabel="Run mode"
              value={paced ? 1 : 0}
              onChange={(v) => selectMode(v === 1)}
              options={[
                { label: 'One-shot', value: 0 },
                { label: 'Paced flight', value: 1 },
              ]}
            />
            {paced && (
              <Slider
                label="Flight budget"
                value={flightBudget}
                min={maxFlightBudget * 0.06}
                max={maxFlightBudget}
                step={maxFlightBudget / 1000}
                display={money(flightBudget, 0)}
                color={C.analytics}
                onChange={setFlightBudget}
              />
            )}
            <button onClick={run} className="mt-1 flex items-center justify-center gap-2 rounded-full bg-lime py-2.5 font-semibold text-console transition-transform active:scale-[0.98]">
              <span aria-hidden>▶</span>
              {paced ? `Run flight · ${FLIGHT_INTERVALS} intervals` : `Run ${intc(OPPORTUNITIES)} auctions`}
            </button>
          </div>

          {paced && pacedResult ? (
            <PacedTiles r={pacedResult} />
          ) : result && scoreVal != null ? (
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
            <p className="px-1 text-[12.5px] text-white/45">
              {paced ? 'Run the flight to see budget pacing over the campaign.' : 'Run the market to see realized results and your score.'}
            </p>
          )}
        </div>

        <div className="rounded-2xl border border-white/10 bg-white/[0.03] p-4">
          {paced && pacedResult ? (
            <PacingChart r={pacedResult} />
          ) : (
            <>
              <div className="flex flex-wrap gap-x-4 gap-y-1">
                <Legend color={C.lime} label="expected profit" />
                <Legend color={C.lime} label="your bid" />
                <Legend color={C.down} label="floor" />
                <Legend color={C.analytics} label="optimal" />
              </div>
              <div className="mt-3">
                <ProfitCurve points={profitCurve} xMax={value} yMax={Math.max(optimal.expectedProfit * 1.2, 1e-4)} bid={bid} floor={floor} optimalBid={optimal.bid} optimalProfit={optimal.expectedProfit} />
              </div>
              <div className="mt-1 flex justify-between font-mono text-[10px] text-white/40">
                <span>bid → {money(0, 0)}</span>
                <span>{money(value, 2)}</span>
              </div>
            </>
          )}
        </div>
      </div>

      <div className="mt-5 rounded-2xl border border-analytics/20 bg-analytics/[0.04] p-4">
        <div className="font-mono text-[10px] uppercase tracking-wide text-analytics">Open the hood</div>
        <p className="mt-2 font-mono text-[13px] text-white/80">
          {secondPrice ? 'E[π / opp] = ∫ (value − c) · f(c) dc' : 'E[π / opp] = P_win(bid) · (value − bid)'}
        </p>
        <ul className="mt-2 list-disc space-y-1 pl-5 text-[12.5px] text-white/55">
          <li>Competing clearing price is log-normal with mean {money(s.marketMean, 2)} and log spread σ = {s.marketSigma.toFixed(2)}, so the win curve is the log-normal CDF — the S-shaped bid landscape.</li>
          <li>Value per impression = CTR × CVR × revenue per conversion.</li>
          <li>{secondPrice ? 'Second-price clearing: the winner pays max(clearing price, floor), so bidding true value is optimal.' : 'First-price clearing: the winner pays its own bid, so the optimal bid shades below value.'}</li>
          <li>{paced ? 'Paced flight: 12 intervals with a proportional pacing throttle and an intraday market that swings volume and competition.' : `Publisher floor ${money(floor, 2)} is the reserve: a bid below it never clears.`}</li>
        </ul>
      </div>
    </section>
  )
}

function PacedTiles({ r }: { r: PacedFlightResult }) {
  const u = r.budgetUtilization
  const color = u >= 0.9 ? C.up : u >= 0.6 ? C.lime : C.down
  return (
    <div className={card}>
      <div className="flex items-center justify-between">
        <span className="font-mono text-[10px] uppercase tracking-wide text-white/40">Flight result</span>
        <span className="font-mono text-[11px] text-analytics">{FLIGHT_INTERVALS} intervals · proportional pacing</span>
      </div>
      <div className="font-mono text-5xl font-extrabold tabular-nums" style={{ color }}>
        {pct(u, 0)}
      </div>
      <div className="font-mono text-[10px] text-white/40">of the flight budget delivered</div>
      <div className="mt-3 grid grid-cols-2 gap-3">
        <Stat label="Spend" value={money(r.totalSpend, 0)} />
        <Stat label="Budget" value={money(r.flightBudget, 0)} />
        <Stat label="Impressions" value={intc(r.impressionsWon)} />
        <Stat label="Conversions" value={intc(r.conversions)} />
        <Stat label="Revenue" value={money(r.revenue, 0)} color={C.up} />
        <Stat label="Profit" value={money(r.profit, 0)} color={r.profit >= 0 ? C.up : C.down} />
        <Stat label="Pacing error" value={pct(r.pacingError)} color={r.pacingError <= 0.1 ? C.up : C.down} />
      </div>
    </div>
  )
}

function PacingChart({ r }: { r: PacedFlightResult }) {
  const yMax = Math.max(r.flightBudget, r.totalSpend) * 1.05
  const target = [{ x: 0, y: 0 }, ...r.points.map((p) => ({ x: p.fractionElapsed, y: p.targetCumulativeSpend }))]
  const actual = [{ x: 0, y: 0 }, ...r.points.map((p) => ({ x: p.fractionElapsed, y: p.cumulativeSpend }))]
  const winRate = r.points.map((p) => ({ x: p.fractionElapsed, y: p.winRate * yMax }))
  return (
    <>
      <div className="flex flex-wrap gap-x-4 gap-y-1">
        <Legend color={C.analytics} label="on-pace target" />
        <Legend color={C.lime} label="actual spend" />
        <Legend color={C.planning} label="win rate (0–100%)" />
      </div>
      <div className="mt-3">
        <LineChart
          series={[
            { color: C.analytics, points: target },
            { color: C.lime, points: actual },
            { color: C.planning, points: winRate, width: 1.5 },
          ]}
          xDomain={[0, 1]}
          yDomain={[0, Math.max(yMax, 1e-4)]}
          ariaLabel="Cumulative spend versus the on-pace target across the flight, with win rate"
        />
      </div>
      <div className="mt-1 flex justify-between font-mono text-[10px] text-white/40">
        <span>flight start · market varies intraday</span>
        <span>flight end</span>
      </div>
    </>
  )
}
