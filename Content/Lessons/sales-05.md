---
id: sales-05
track: sales
module: 5
title: PMP, PG, and preferred deals
summary: Tell apart private marketplaces, programmatic guaranteed, and preferred deals by their priority, pricing, and who carries the delivery risk.
---
# Deals sit above the open exchange

The open exchange is the spot market: anyone bids, prices float, and the highest bid wins. Deals are private arrangements layered on top, giving named buyers priority access to specific inventory at agreed terms. Each deal carries a deal ID, a unique string a DSP uses to bid against that package.

Three deal types dominate, and they differ on two axes: priority (who gets first look) and commitment (whether volume and price are locked). Understanding where each sits tells you how to price it and who absorbs the risk if delivery falls short.

:::widget barChart
title: Typical CPM by deal type (illustrative)
labels: PG, PMP, Preferred, Open
data: 18, 12, 10, 4
unit: $
:::

# Programmatic guaranteed

Programmatic guaranteed (PG) is the closest thing to a traditional direct buy, executed through the pipes. It is a one-to-one deal where the buyer commits to a fixed volume of impressions at a fixed CPM, and the publisher reserves that inventory. Both sides are locked: guaranteed volume, guaranteed price.

PG sits at the top of the priority stack, ahead of all non-guaranteed demand. Because the price is fixed and volume is committed, the publisher carries delivery risk and the buyer carries the price. PG commands the highest CPMs because it offers certainty to both parties.

:::callout key
Programmatic guaranteed locks both volume and price. It gets first look at inventory and trades the highest CPM for mutual commitment.
:::

:::predict
prompt: A PG deal commits 3,000,000 impressions at a fixed $18 CPM. What is the locked-in revenue for the publisher?
answer: 54000
unit: $
hint: Revenue equals impressions divided by 1000, times the CPM.
explain: Revenue = 3,000,000 / 1000 x $18 = 3,000 x $18 = $54,000. Because both volume and price are fixed, this revenue is guaranteed as long as the publisher delivers, which is why the publisher carries the delivery risk.
:::

# Preferred deals

A preferred deal is a fixed price with no volume commitment. The buyer gets the first look at inventory at a negotiated CPM but is not obligated to buy, and the publisher does not reserve the inventory. If the buyer passes, the impression flows down to the next buyer or the open market.

This is a one-to-one, non-guaranteed arrangement. It gives a favored buyer a fixed-price option without either side committing to volume, useful when a buyer wants priority access but cannot promise spend, or when a publisher wants a backstop above the open-market floor.

:::predict
prompt: A preferred deal offers first look on 2,000,000 impressions at a fixed $10 CPM, but the buyer only takes the impressions it wants. If the buyer accepts 40 percent of them, what revenue does the deal generate?
answer: 8000
unit: $
hint: Apply the take-up rate to the impressions first, then convert to revenue at the CPM.
explain: Accepted = 2,000,000 x 0.40 = 800,000 impressions. Revenue = 800,000 / 1000 x $10 = $8,000. With no volume commitment, the publisher cannot count on the full 2,000,000, so a preferred deal earns less certainty than PG.
:::

# Private marketplace

A private marketplace (PMP) is an invite-only auction. Selected buyers compete for premium inventory at or above a negotiated floor, before that inventory is exposed to the open exchange. Unlike PG, it is an auction, so the price is set by competition, not fixed in advance.

$$ Priority: PG \to PMP \to Open $$

PMP sits between guaranteed deals and the open exchange in priority. It earns publishers higher CPMs than the open market because demand for premium, brand-safe inventory concentrates competition among a curated buyer pool. The explorer below shows how priority and floors route a single impression through these layers.

:::widget yieldExplorer
:::

:::callout insight
The deal hierarchy is priority first, then price. PG reserves and fixes price, PMP competes above a floor, the open exchange takes whatever is left.
:::

:::quiz
question: What is the key difference between programmatic guaranteed and a preferred deal?
- PG commits both volume and price, while a preferred deal fixes price but commits no volume
- PG runs as an open auction, while a preferred deal is fixed price
- Preferred deals always pay higher CPMs than PG
- PG has no deal ID, while preferred deals do
answer: 0
explain: PG reserves a guaranteed volume at a fixed CPM, so both sides are committed. A preferred deal offers a fixed price with a first look but no volume guarantee, so the buyer can decline.
:::

:::sources
- The Ultimate Private Marketplace Guide for Publishers, Publift | https://www.publift.com/adteach/ultimate-guide-to-the-private-marketplace-for-publishers
- The 4 Programmatic Deal Types, Blockthrough | https://blockthrough.com/blog/guide-to-the-4-programmatic-deal-types/
:::
