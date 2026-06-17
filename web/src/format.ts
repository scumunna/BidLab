// Display formatters mirroring the native app's money / pct / int helpers
// (Sources/BidLab/Surfaces/TradingFloor/TradingFloorView.swift).

export function money(x: number, digits = 2): string {
  if (!Number.isFinite(x)) return '—'
  return (
    '$' +
    x.toLocaleString('en-US', {
      minimumFractionDigits: digits,
      maximumFractionDigits: digits,
    })
  )
}

export function pct(x: number, digits = 1): string {
  if (!Number.isFinite(x)) return '—'
  return (x * 100).toFixed(digits) + '%'
}

export function intc(x: number): string {
  return Math.round(x).toLocaleString('en-US')
}
