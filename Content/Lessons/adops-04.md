---
id: adops-04
track: adops
module: 4
title: Creative Specs and QA
summary: The display sizes that carry the inventory, the file-weight and LEAN rules that govern them, video and CTV encoding specs, and the pre-launch QA checklist that keeps a creative from rejecting or serving blank.
---
# The sizes that actually carry the inventory

A media plan can name a dozen banner sizes, but a handful do almost all the work. The IAB New Ad Portfolio recommends a small set of fixed sizes chosen, by the IAB's own Attitudes and Usage study, because they contribute the majority of revenue and serve across screens. In practice five sizes cover the bulk of programmatic placements: the 300x250 medium rectangle, the 728x90 leaderboard, the 160x600 wide skyscraper, the 300x600 half page, and the 320x50 mobile banner. The 970x250 billboard is the big-canvas premium unit on top.

The 300x250 is the single most placed unit because it drops cleanly into article bodies and sidebars and renders on both desktop and mobile. The 728x90 and 160x600 are desktop workhorses, the 320x50 is the mobile default at the top or bottom of the screen, and the 300x600 wins on viewability because it is tall and hard to scroll past. If you only trafficked those, you would still reach most of the open web.

:::quiz
question: Which single display size is most commonly placed across desktop and mobile, fitting inside article bodies and sidebars?
- 970x250 billboard
- 728x90 leaderboard
- 300x250 medium rectangle
- 160x600 wide skyscraper
answer: 2
hint: It is a compact rectangle that renders the same on a phone and a laptop.
explain: The 300x250 medium rectangle is the most widely placed unit because it fits inside content and sidebars and renders on both desktop and mobile. The leaderboard, skyscraper, and billboard are larger and more desktop-skewed.
:::

# File weight: initial load, subload, total

A creative is not one number. The IAB splits its weight into phases. The initial load is every asset needed to paint the first frame and fire tracking, requested before the host page's window load event. The host-initiated subload (the term that replaced the old "polite load") is the extra weight the ad may pull after that load event has fired, used by richer units to bring in heavier assets without slowing the page. After a real user interaction, like a click or expand, the user-initiated load has no weight cap at all.

The IAB New Ad Portfolio sets a maximum k-weight (the gzipped size) per size for each phase. The medium rectangle (300x250), leaderboard (728x90), and skyscraper (160x600) each allow 150 KB on initial load and 300 KB on subload. The 320x50 mobile banner allows 50 KB initial and 100 KB subload. The 300x600 half page and 970x250 billboard sit higher, around 250 KB initial and 500 KB subload. Initial load is also capped at 10 file requests, and shared libraries the publisher exempts get a combined 50 KB pass.

:::widget barChart
title: IAB maximum initial-load k-weight by unit (KB, gzipped)
labels: 320x50, 300x250, 728x90, 160x600, 970x250, 300x600
data: 50, 150, 150, 150, 250, 250
unit:
:::

:::predict
prompt: A 300x250 HTML5 creative ships 95 KB of images, a 28 KB JS library, and 22 KB of HTML and CSS on initial load, all gzipped. The IAB initial-load cap for this size is 150 KB. How many KB of headroom is left before it fails the limit?
answer: 5
tolerance: 0.5
unit:
hint: Add the three initial-load parts, then subtract from the cap.
explain: Initial load is 95 + 28 + 22 = 145 KB. The cap is 150 KB, so 150 minus 145 leaves 5 KB of headroom. The creative passes, but barely, so one more asset would push it over.
:::

# LEAN, HTML5, and serving secure

The weight rules sit inside the IAB's LEAN framework: Light, Encrypted, AdChoices supported, and Non-invasive. Light is the k-weight and CPU discipline above (the portfolio also asks for roughly 30 percent CPU load max per active ad). Encrypted is the requirement to serve over a secure connection. AdChoices supported means the interest-based-advertising icon and controls, kept under a 5 KB budget. Non-invasive means muted audio by default and no behavior that hijacks the page.

Static GIF and JPEG creatives still exist, but HTML5 is the modern animated unit, a small bundle of HTML, CSS, JavaScript, and images, with animation that should run asynchronously and stop when the ad is out of view. The Encrypted rule is hard and operational: on a secure (HTTPS) page every ad asset and tracking call must also be HTTPS, or the browser blocks it as mixed content. Google Ad Manager scans non-hosted creatives for SSL compatibility within 12 hours, and an ad marked SSL-compliant that emits any non-secure response is disapproved. The one carve-out is the final click-through URL, which may be HTTP or HTTPS without breaking compliance.

:::callout key
Every asset and tracking pixel must serve over HTTPS on a secure page, or the browser strips it as mixed content and the impression renders blank. The click-through destination URL is the only part allowed to stay HTTP.
:::

:::quiz
question: A display creative on an HTTPS page loads one of its background images from an http:// URL. What happens?
- The whole page refuses to load
- The browser blocks that image as mixed content and the ad can render broken or blank
- Nothing, browsers upgrade http to https automatically for ad assets
- The image loads but the click-through stops working
answer: 1
hint: Secure pages do not allow insecure sub-resources.
explain: On an HTTPS page the browser blocks insecure (http) sub-resources as mixed content, so that asset fails to load and the ad can render broken or blank. The fix is to serve every asset and pixel over HTTPS. Only the click-through destination URL is allowed to remain http.
:::

# Animation length and loop limits

Motion sells, but the IAB caps it so a banner cannot loop forever and burn CPU. Animation length is limited to 15 seconds, and the animation may loop no more than 3 times before it must come to rest on a final frame. In-page banners must also delay starting their animation until the page's load event fires, and animation should not run while the ad is scrolled out of view. These are not style notes, they are the difference between a clean placement and one a publisher or verification vendor flags as non-compliant.

:::predict
prompt: An HTML5 banner runs a 4-second animation sequence and the IAB allows it to loop a maximum of 3 times. What is the maximum total animation time, in seconds, before it must rest on a static end frame?
answer: 12
tolerance: 0
unit: s
hint: Total time is the loop length multiplied by the maximum number of loops.
explain: 4 seconds per loop times the 3-loop maximum is 12 seconds of animation, which is within the 15-second ceiling. After the third loop the banner must hold on a final static frame.
:::

# Video and CTV: resolution, duration, bitrate, audio

Video creative follows the IAB Tech Lab Digital Video and CTV guidelines. Aspect ratio is 16:9 preferred, with 4:3 accepted for legacy source and 21:9 emerging for ultrawide. Linear ad duration should be one of 6, 15, or 30 seconds, with 6-to-10-second bumpers and the occasional 60-second spot also accepted. The standard codec is H.264, delivered as web-optimized MP4 for progressive download or HLS and MPEG-DASH for adaptive streaming, plus a high-quality mezzanine master (50 Mbps) the publisher transcodes from.

Bitrate scales with resolution. The IAB target is 1500 to 2500 kbps for 720p (1280x720) and 2500 to 3500 kbps for 1080p (1920x1080), while CTV vendors commonly ask for far higher rates, on the order of 15,000 to 30,000 kbps, because the ad plays on a large living-room screen. Audio is AAC, 128 to 192 kbps for AAC-LC or 64 to 128 kbps for HE-AACv1, a 2-channel stereo mix at a 44.1 or 48 kHz sample rate. Loudness is normalized to -24 LKFS in the US (ATSC A/85) or -23 LUFS in the EU (EBU R128), with peaks not exceeding -6 dB true peak, the same discipline that keeps a podcast or audio (DAAST-style) ad from blasting the listener.

:::widget barChart
title: IAB target video bitrate by resolution (kbps)
labels: 360p low, 576p medium, 720p HD, 1080p HD
data: 600, 1100, 2000, 3000
unit:
:::

:::predict
prompt: The IAB notes a video runs about 1.5 MB per 15 seconds at a 1000 kbps bitrate. Holding that ratio, roughly how many MB is a 30-second spot at the same 1000 kbps?
answer: 3
tolerance: 0.2
unit: MB
hint: File size scales with duration at a fixed bitrate. Double the seconds, double the size.
explain: At a fixed 1000 kbps, doubling 15 seconds to 30 seconds doubles the file size, so 1.5 MB becomes about 3 MB. Higher bitrates for 1080p or CTV push that number up sharply.
:::

# The pre-launch creative QA checklist

QA is the cheapest insurance in ad ops, because a creative that fails after launch wastes budget and can run blank or off-brand for hours before anyone notices. Walk every creative through the same checklist before it goes live.

Confirm dimensions match the trafficked size exactly (a 300x250 in a 300x600 slot serves letterboxed or rejects). Confirm file weight is under the IAB initial-load and subload caps for that size. Confirm SSL: every asset and pixel is HTTPS, nothing mixed-content. Confirm the click-through actually opens and lands on the correct, live page, not a 404 or a stale campaign. Confirm the click tracker fires (watch the network panel for the tracking call before the redirect). Confirm there is no auto-playing audio, the unit is muted until a user acts. For video and CTV, confirm aspect ratio, duration, and that loudness is normalized so the ad does not spike.

:::callout insight
The two failures that hurt most are silent: a click tracker that does not fire (so the campaign looks like it underperforms when clicks just are not counted) and a mixed-content asset that renders the ad blank on secure pages. Both are invisible in a quick eyeball check and both are caught only by watching the network panel.
:::

:::quiz
question: During pre-launch QA you click the creative, the landing page opens correctly, but the network panel shows no request to the click-tracking URL. What is the right call?
- Launch anyway, the landing page works so the click is fine
- Hold the creative, because clicks will go uncounted and the campaign will look like it underperforms
- Only a problem for video, ignore it for display
- Re-upload the image asset
answer: 1
hint: A working landing page and a firing click tracker are two separate things.
explain: The click tracker firing is what records the click for reporting and billing. If it does not fire, clicks go uncounted and the campaign appears to underperform even though users are clicking through. Hold the creative and fix the click macro or tag before launch.
:::

:::sources
- IAB Tech Lab, New Standard Ad Unit Portfolio Fixed Size Spec | https://www.iab.com/wp-content/uploads/2019/04/IABNewAdPortfolio_LW_FixedSizeSpec.pdf
- IAB Tech Lab, New Ad Portfolio July 2017 (LEAN and load phases) | https://www.iab.com/wp-content/uploads/2019/07/IABNewAdPortfolio_FINAL_0719.pdf
- IAB Tech Lab, Ad Format Guidelines for Digital Video and CTV (Aug 2022) | https://iabtechlab.com/wp-content/uploads/2022/03/Ad-Format-Guidelines_DV-CTV.pdf
- Google Ad Manager Help, Check creatives for SSL compatibility | https://support.google.com/admanager/answer/4515432?hl=en
- Google Ad Manager Help, HTML5 guidelines for Ad Manager | https://support.google.com/admanager/answer/7046799?hl=en
- Adobe, Working with IAB guidelines (animation length and looping) | https://helpx.adobe.com/animate/using/best-practices-advertising.html
- Publift, Highest-performing AdSense banner sizes and formats | https://www.publift.com/blog/highest-performing-adsense-banner-sizes-formats
:::
