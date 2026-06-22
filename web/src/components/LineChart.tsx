// A small, reusable SVG line chart (no chart dependency), mirroring the native
// app's CurveChart. Supports multiple series, an optional area fill, and
// vertical / horizontal / point markers.

export interface ChartPoint {
  x: number
  y: number
}

export interface ChartSeries {
  color: string
  points: ChartPoint[]
  width?: number
  fill?: boolean
}

export type ChartMarker =
  | { kind: 'vertical'; x: number; color: string }
  | { kind: 'horizontal'; y: number; color: string }
  | { kind: 'point'; x: number; y: number; color: string }

interface Props {
  series: ChartSeries[]
  xDomain: [number, number]
  yDomain: [number, number]
  markers?: ChartMarker[]
  ariaLabel: string
}

const W = 600
const H = 280
const PAD_L = 6
const PAD_R = 10
const PAD_T = 14
const PAD_B = 6

export function LineChart({ series, xDomain, yDomain, markers = [], ariaLabel }: Props) {
  const plotW = W - PAD_L - PAD_R
  const plotH = H - PAD_T - PAD_B
  const [x0, x1] = xDomain
  const [y0, y1] = yDomain
  const sx = (x: number) => PAD_L + (x1 > x0 ? (x - x0) / (x1 - x0) : 0) * plotW
  const sy = (y: number) => PAD_T + plotH - (y1 > y0 ? (y - y0) / (y1 - y0) : 0) * plotH

  const gridYs = [0.25, 0.5, 0.75].map((f) => PAD_T + plotH * f)

  return (
    <svg
      viewBox={`0 0 ${W} ${H}`}
      preserveAspectRatio="xMidYMid meet"
      className="w-full"
      style={{ aspectRatio: `${W} / ${H}` }}
      role="img"
      aria-label={ariaLabel}
    >
      {gridYs.map((y, i) => (
        <line key={i} x1={PAD_L} y1={y} x2={W - PAD_R} y2={y} stroke="#ffffff" strokeOpacity="0.06" strokeWidth="1" />
      ))}

      {series.map((s, si) => {
        const path = s.points.map((p, i) => `${i === 0 ? 'M' : 'L'} ${sx(p.x).toFixed(2)} ${sy(p.y).toFixed(2)}`).join(' ')
        const last = s.points[s.points.length - 1]
        const first = s.points[0]
        return (
          <g key={si}>
            {s.fill && first && last && (
              <path d={`${path} L ${sx(last.x).toFixed(2)} ${sy(y0).toFixed(2)} L ${sx(first.x).toFixed(2)} ${sy(y0).toFixed(2)} Z`} fill={s.color} fillOpacity="0.08" />
            )}
            <path d={path} fill="none" stroke={s.color} strokeWidth={s.width ?? 2.5} vectorEffect="non-scaling-stroke" strokeLinejoin="round" />
          </g>
        )
      })}

      {markers.map((m, i) => {
        if (m.kind === 'vertical') {
          return <line key={i} x1={sx(m.x)} y1={PAD_T} x2={sx(m.x)} y2={PAD_T + plotH} stroke={m.color} strokeWidth="1.5" strokeDasharray="5 4" strokeOpacity="0.9" vectorEffect="non-scaling-stroke" />
        }
        if (m.kind === 'horizontal') {
          return <line key={i} x1={PAD_L} y1={sy(m.y)} x2={W - PAD_R} y2={sy(m.y)} stroke={m.color} strokeWidth="1.5" strokeDasharray="5 4" strokeOpacity="0.7" vectorEffect="non-scaling-stroke" />
        }
        return <circle key={i} cx={sx(m.x)} cy={sy(m.y)} r="5.5" fill={m.color} stroke="#0e0e15" strokeWidth="2.5" />
      })}
    </svg>
  )
}
