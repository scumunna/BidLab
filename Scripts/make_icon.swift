import AppKit

// Draws the BidLab app icon: a violet rounded square with a rising lime curve.
let size = 1024
let image = NSImage(size: NSSize(width: size, height: size))
image.lockFocus()
let ctx = NSGraphicsContext.current!.cgContext
let s = CGFloat(size)

func rgb(_ r: Int, _ g: Int, _ b: Int) -> CGColor {
    NSColor(srgbRed: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1).cgColor
}

let rect = CGRect(x: 0, y: 0, width: s, height: s)
let radius = s * 0.225
ctx.addPath(CGPath(roundedRect: rect, cornerWidth: radius, cornerHeight: radius, transform: nil))
ctx.setFillColor(rgb(0x5B, 0x2B, 0xFF))
ctx.fillPath()

ctx.setStrokeColor(rgb(0xB6, 0xFF, 0x3A))
ctx.setLineWidth(s * 0.075)
ctx.setLineCap(.round)
ctx.setLineJoin(.round)
let points: [(CGFloat, CGFloat)] = [(0.24, 0.40), (0.43, 0.58), (0.58, 0.47), (0.78, 0.70)]
ctx.beginPath()
for (i, p) in points.enumerated() {
    let pt = CGPoint(x: p.0 * s, y: p.1 * s)
    if i == 0 { ctx.move(to: pt) } else { ctx.addLine(to: pt) }
}
ctx.strokePath()
// arrow head at the rising end
let tip = CGPoint(x: 0.78 * s, y: 0.70 * s)
ctx.beginPath()
ctx.move(to: CGPoint(x: tip.x - s * 0.11, y: tip.y))
ctx.addLine(to: tip)
ctx.addLine(to: CGPoint(x: tip.x, y: tip.y - s * 0.11))
ctx.strokePath()

image.unlockFocus()
let data = image.tiffRepresentation!
let rep = NSBitmapImageRep(data: data)!
let png = rep.representation(using: .png, properties: [:])!
try! png.write(to: URL(fileURLWithPath: CommandLine.arguments[1]))
print("wrote \(CommandLine.arguments[1])")
