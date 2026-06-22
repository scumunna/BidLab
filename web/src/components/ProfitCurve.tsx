// The expected-profit-per-opportunity curve, hand-rolled in SVG (no chart
// dependency, matching BidLab's CurveChart). Shows your bid, the publisher floor,
// and the profit-maximizing bid as markers.

import { money } from '../format'

export interface CurvePoint {
  x: number
  y: number
}

interface Props {
  points: CurvePoint[]
  xMax: number
  yMax: number
  bid: number
  floor: number
  optimalBid: number
  optimalProfit: number
}

const W = 600
const H = 280
const PAD_L = 6
const PAD_R = 10
const PAD_T = 14
const PAD_B = 6

export function ProfitCurve({ points, xMax, yMax, bid, floor, optimalBid, optimalProfit }: Props) {
  const plotW = W - PAD_L - PAD_R
  const plotH = H - PAD_T - PAD_B
  const sx = (x: number) => PAD_L + (xMax > 0 ? x / xMax : 0) * plotW
  const sy = (y: number) => PAD_T + plotH - (yMax > 0 ? Math.max(0, y) / yMax : 0) * plotH

  const line = points.map((p, i) => `${i === 0 ? 'M' : 'L'} ${sx(p.x).toFixed(2)} ${sy(p.y).toFixed(2)}`).join(' ')
  const area =
    points.length > 0
      ? `${line} L ${sx(points[points.length - 1].x).toFixed(2)} ${sy(0).toFixed(2)} L ${sx(points[0].x).toFixed(2)} ${sy(0).toFixed(2)} Z`
      : ''

  const gridYs = [0.25, 0.5, 0.75].map((f) => PAD_T + plotH * f)

  return (
    <svg
      viewBox={`0 0 ${W} ${H}`}
      preserveAspectRatio="xMidYMid meet"
      className="w-full"
      style={{ aspectRatio: `${W} / ${H}` }}
      role="img"
      aria-label="Expected profit per opportunity across bid prices, with markers for your bid, the publisher floor, and the optimal bid"
    >
      {gridYs.map((y, i) => (
        <line key={i} x1={PAD_L} y1={y} x2={W - PAD_R} y2={y} stroke="#ffffff" strokeOpacity="0.06" strokeWidth="1" />
      ))}

      {area && <path d={area} fill="#b6ff3a" fillOpacity="0.08" />}
      {line && <path d={line} fill="none" stroke="#b6ff3a" strokeWidth="2.5" vectorEffect="non-scaling-stroke" strokeLinejoin="round" />}

      {floor > 0 && (
        <line
          x1={sx(floor)}
          y1={PAD_T}
          x2={sx(floor)}
          y2={PAD_T + plotH}
          stroke="#ff3b5c"
          strokeWidth="1.5"
          strokeDasharray="5 4"
          strokeOpacity="0.75"
          vectorEffect="non-scaling-stroke"
        />
      )}

      <line
        x1={sx(bid)}
        y1={PAD_T}
        x2={sx(bid)}
        y2={PAD_T + plotH}
        stroke="#b6ff3a"
        strokeWidth="1.5"
        strokeDasharray="5 4"
        strokeOpacity="0.9"
        vectorEffect="non-scaling-stroke"
      />

      <circle cx={sx(optimalBid)} cy={sy(optimalProfit)} r="5.5" fill="#00b4d8" stroke="#0e0e15" strokeWidth="2.5" />
      <title>{`Optimal bid ${money(optimalBid, 3)}`}</title>
    </svg>
  )
}
