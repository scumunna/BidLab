---
id: engineering-06
track: engineering
module: 6
title: Model serving
summary: See how a bidder fetches features, runs inference inside the latency budget, and trades model accuracy against the milliseconds it costs.
---
# The prediction lives on the hot path

The value of a bid depends on a prediction, usually the probability that the user will click or convert. That prediction comes from a machine learning model, and unlike training, inference happens inside the live request, against the same deadline as everything else. Model serving is the engineering of running that model fast enough to bid.

The work splits in two: fetch the features the model needs, then run the forward pass. Both must fit in the few milliseconds of inference budget the request can spare after parsing and candidate selection.

:::widget distributionExplorer
:::

# Feature stores serve features in milliseconds

A model scores on features: counts, rates, embeddings, and context about the user, the inventory, and the campaign. Many of those features are precomputed and stored in an online feature store, a low-latency key-value store keyed by entity (user ID, placement ID) that returns a feature vector in single-digit milliseconds.

The split is deliberate. An offline store keeps deep history for training. The online store sacrifices history for speed, holding only the current values the bidder needs to look up at request time. Request-time features (the actual ad slot, time of day) are computed inline and concatenated with the fetched vector before scoring.

:::callout key
A feature store has two halves: an offline store with full history for training, and an online store optimized to return the current feature vector in milliseconds for live inference.
:::

:::predict
prompt: The bidder has an 8 ms inference budget. The online feature store returns the feature vector in 3 ms. How many milliseconds are left for the model forward pass?
answer: 5
unit: ms
hint: Subtract the feature fetch time from the total inference budget.
explain: 8 ms budget - 3 ms feature fetch = 5 ms left for the forward pass. If the model cannot score within 5 ms, the bidder must shrink the model or fall back to a cheaper estimate.
:::

# Inference under a deadline

Once features are assembled, the model runs a forward pass. CTR models in production score above 100,000 QPS, so inference is served from systems built for low latency, often a dedicated serving runtime, with batching, quantization, and pruning to cut the cost per score. Some teams parallelize feature fetch and partial computation rather than running them strictly in sequence to claw back milliseconds.

The relationship you are managing is direct: total inference time is the feature fetch plus the model compute, and it has to fit the budget.

$$ t_{infer} = t_{features} + t_{forward} \le t_{budget} $$

If either term grows past the budget, the bidder must fall back to a cheaper estimate or skip scoring that candidate. A served prediction that arrives late helps no one.

:::predict
prompt: Feature fetch takes 4 ms and the model forward pass takes 6 ms. Using t_infer = t_features + t_forward, what is the total inference time in milliseconds?
answer: 10
unit: ms
hint: Add the feature fetch time and the forward-pass time.
explain: t_infer = 4 + 6 = 10 ms. If the inference budget were only 8 ms, this candidate would blow the deadline and the bidder would have to fall back to a cheaper estimate.
:::

# The accuracy versus latency tradeoff

A bigger model usually predicts better, but it costs more milliseconds, and milliseconds past the deadline cost you the entire auction. So model serving is a constant tradeoff: the most accurate model is not the right one if it blows the budget at peak QPS. The right model is the one that maximizes expected profit per request given the time it consumes.

In practice teams shrink models (pruning, distillation, lower-precision arithmetic) to recover accuracy at lower latency, and they keep a fast fallback for when the clock runs short. The lab below walks through the scoring path so you can see where features, inference, and the fallback fit.

:::callout insight
The best model for bidding is not the most accurate one. It is the one that maximizes expected profit per request, because any accuracy gain that pushes you past the deadline is worth zero.
:::

:::widget codeLab
:::

:::quiz
question: Why is the most accurate available model not necessarily the right one to serve in a bidder?
- Accurate models are always cheaper to run
- If its inference latency pushes the response past the exchange deadline, the bid is dropped and the accuracy gain is worthless
- OpenRTB caps model size
- Feature stores cannot serve large models
answer: 1
explain: Inference runs on the hot path against a hard deadline. A more accurate but slower model that causes timeouts loses the whole auction, so the goal is expected profit per request, not raw accuracy.
:::

:::sources
- Feature Serving and Model Inference, Feast docs | https://docs.feast.dev/getting-started/architecture/model-inference
- On the Factory Floor: ML Engineering for Industrial-Scale Ads Recommendation Models | https://arxiv.org/pdf/2209.05310
:::
