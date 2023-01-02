<div align="center">

# Learn Payment Processing 💳

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/dwyl/learn-payment-processing/ci.yml?label=build&style=flat-square&branch=main)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/learn-payment-processing/main.svg?style=flat-square)](https://codecov.io/github/dwyl/phoenix-chat-example?branch=main)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/phoenix-chat-example/issues)  
[![HitCount](https://hits.dwyl.com/dwyl/learn-payment-processing.svg?style=flat-square&show=unique)](http://hits.dwyl.com/dwyl/learn-payment-processing)
  
Learn what payment processing is 
and how you can add it to your App
to get _paid_! 🎉

</div>

# Why? 🥕

Sadly, not all applications can be "free";
the **`people`** that build them need to be **paid**
and the underlying infrastructure costs money too.
Many App/Websites cover their costs through advertising.
This is effectively selling [out] the "users" data,
which we are 
[not fans](https://github.com/dwyl/learn-react/issues/23#issuecomment-552212087) 
of ...

[![you-are-the-product](https://user-images.githubusercontent.com/194400/210129020-c3fe00a5-5721-448b-a919-7b9c89ba2fae.png "You Are the Product!")](https://slate.com/technology/2018/04/are-you-really-facebooks-product-the-history-of-a-dangerous-idea.html)

> "_When something online is free, 
> you're not the customer, 
> you're the product._" 
> ~ [Jonathan Zittrain](https://blogs.harvard.edu/futureoftheinternet/2012/03/21/meme-patrol-when-something-online-is-free-youre-not-the-customer-youre-the-product/)

We prefer to charge an affordable fee -
enough to cover all our costs 
and continue building our 
[roadmap](https://github.com/dwyl/product-roadmap) -
and _fiercely_ guard the privacy 
of the `people` using the App.

# Who? 🤓

This guide is meant as both an **_internal_ reference** fo us **`@dwyl`** <br />
and a _fully_ Open Source resource that _anyone_ can read and learn from.

As always, if you find it helpful/useful please ⭐ 🙏 Thanks!

If you get stuck or have any questions/suggestions,
please [open an issue](https://github.com/dwyl/learn-payment-processing/issues).


# What 💭

The goal of this guide is to cover 
both the theory and _practice_ 
of payment processing
_and_ to showcase payment processing
in a standalone web app. 

Some Apps are sold via **one time purchase**
others are **subscription-based** (recurring payments).
Regardless of the type of payment, 
they share one thing in common:
**payment processing gateways 
are used to collect funds**.

But what _is_ "payment processing"...? 


## Payment Processor or Gateway 🤷‍♀️

![payment-processor-gateway](https://user-images.githubusercontent.com/17494745/208946952-4da1600e-9936-4491-9a6e-a5a7e09c023c.png)

A **payment processor** functions as an intermediary
between the customer's bank (or digital wallet)
and the merchant
(and their bank).
It is the entity responsible for communicating
between both parties in the transaction.

A **payment gateway**
is a virtual
[*point of sale*](https://en.wikipedia.org/wiki/Point_of_sale)
for online payments.
Similar to when a customer swipes/taps their card
on a **_physical_ credit card terminal**,
online stores need a gateway to securely collect
the customer's card details. 
A payment gateway 
acts like is a _virtual_ credit card terminal.

The whole process of online payment
usually assumes the merchant
has a 
[**merchant account**](https://www.investopedia.com/terms/m/merchant-account.asp).
A merchant account is simply
a type of business bank account
that *allows a business
to receive credit card 
and other electronic funds transfers*.

> **Note**: the terms 
> `payment processor` 
> and `payment gateway` 
> usually fall under the same term;
`payment processor`. 
This is because they work together to handle payment processing. 
So if you see platforms like `Stripe` 
being mentioned as a "payment processor",
it's because it offers both `payment gateway` 
and `payment processor` 
bundled together 
alongside a myriad of other features 
such as fraud prevention.

## Which Payment Processing Provider? 🤔

There are several Payment processing providers,
the most recognizable are: 
[`PayPal`](https://developer.paypal.com/api/rest/),
[`Stripe`](https://stripe.com)
or 
[`Square`](https://developer.squareup.com/us/en).

We have used each of these in the past 
and they are fairly straightforward to integrate.

Let's do a quick rundown of the various payment providers
we want to support in our `App`:

## `PayPal` - the _Original_ Payment Processor 💵

Started in 1998, 
`PayPal` is one of the _original_
and most successful
general purpose online payment processors.

If you've done much online shopping,
you have probably seen a payment interface
allowing purchases through `Paypal`:

![paypal](https://user-images.githubusercontent.com/17494745/208951049-421e123a-e082-433e-8b08-60c7da8c8a57.png)

If you want to alow `people` to purchase
an through `PayPal`,
you'd have to setup a `PayPal` account
and use one of their SDKs:
[developer.paypal.com](https://developer.paypal.com/home)

This uses the 
`PayPal` E-commerce platform
[paypal.com/us/business/platforms](https://www.paypal.com/us/business/platforms-and-marketplaces)
to setup a payment gateway and processor
for `people` to pay with Paypal on your site.

The biggest advantage of `PayPal` 
is that has been a "Digital Wallet" from the early days.
Which means people _store_ funds in their `PayPal` account
as if it were a Bank.
An individual can _sell_ something online 
e.g. on 
[`eBay`](https://www.ebay.com/help/selling/listings/choosing-get-paid/accepting-other-payment-methods?id=4184)
or 
[`etsy`](https://help.etsy.com/hc/en-us/articles/360000104828-How-to-Pay-With-PayPal?segment=shopping)

The history/evolution of `PayPal` is a fascinating success story,
[wikipedia.org/wiki/PayPal#Early_history](https://en.wikipedia.org/wiki/PayPal).
We are only concerned about the _present_;
`PayPal` has over **`400 million people` _actively_ using their platform** 
and can be used in more than 200 countries/regions.
A _significant_ proportion of `people` buying things online
_already_ use and _trust_ `PayPal`.
We want to offer the ability to checkout with a `PayPal`
account as one of the lowest friction payment methods.
For people who are signed into their `PayPal` account,
checkout can be **2 clicks/taps**. 🚀


## `Apple Pay` 🍎

There are **`1.2 Billion` _active_ `iPhone`** users worldwide.
`iPhone` recently surpassed 
[**`50%` Smart Phone Market Share**](https://github.com/dwyl/learn-flutter/pull/69#issuecomment-1319811970)
in the **US**
and in some wealthier countries like Norway,
it's as high as 
[**`68%`**](https://github.com/dwyl/learn-flutter/pull/69#issuecomment-1319826473).
Many of the `people` using `iPhone`
have a payment card associated with their Apple Account.
[**`Apple Pay`**](https://www.apple.com/apple-pay/)
has **`500 million`** registered users worldwide:
[fortunly.com/apple-pay-statistics](https://fortunly.com/statistics/apple-pay-statistics/)

To use `Apple Pay` _directly_ we would need
to create an account with `Apple`
and use their `SDK`:
[developer.apple.com/apple-pay/implementation/](https://developer.apple.com/apple-pay/implementation/)

`while` we don't expect _many_ of the people using our `App` to pay with `Apple Pay`
(_and we certainly won't encourage them as `Apple` takes a **massive `30%` cut** ..._)

## `Google Pay` 🤖

[`Google Pay`](https://pay.google.com/about/business/implementation/), 
originally called `Google Checkout`,
then `Google Wallet` 
then rebranded to `Android Pay` 
and now back to `Google Pay/Wallet` (...🙄)
is a payment service available 
to all `people` with a `Google` account -
including everyone with an `Android` device -
who have added a credit/debit card to their account.
It's difficult to know exactly how many people
have and _use_ `Google Pay` 
because `Google` does not make the info `public`
and the _vast_ majority of `people` with an `Android`
device either don't _have_ a Credit Card
(think children and the 
[unbanked](https://en.wikipedia.org/wiki/Unbanked)) ...
But the most recent estimates are 
**`200 million` people**
in 
[**47 countries**](https://support.google.com/googlepay/answer/12429287?hl=en#zippy=%2Cpay-in-store).
see: wikipedia.org/wiki/Google_Pay_(payment_method)

To add `Google Pay`
as a payment method 
you have to create an business account 
and use their **`SDK`**:
[developers.google.com/pay/api](https://developers.google.com/pay/api)
and integrate it in your App/Website.

## Credit/Debit Cards 💳

Last but not least are **`credit/debit cards`**, 
by _far_ the most prevalent payment method
both in the _real_ world and online.

All the bran-specific payment providers
such as `Apple Pay`, `Google Pay`, `Amazon Pay` etc.
_assume_ you have a `credit/debit card`,
so why _bother_ with the others?
Simple: most friction and _perceived_ security.
Many people are _reluctant_ to use their credit/debit card
because they fear fraud or identity theft.

These fears are _mostly_ resolved in 2022
as the credit/debit card companies have
sophisticated fraud detection/prevention systems.
But we [@dwyl] still don't want to be _storing_ 
any card details ourselves, we want a trusted 
[PCI DSS compliant](https://en.wikipedia.org/wiki/Payment_Card_Industry_Data_Security_Standard)
payment processor to handle the parts we don't have time to be experts in
so that we can focus on the UI/UX of our `App`.

## Merchant Account? 🛒

On top of managing accounts with each of the payment providers,
we would need to create our own merchant account
so each one of these services can connect to it
and process the transactions.

Setting up and maintaining a Merchant Account 
is a heap of effort 
and can easily require
a _dedicated_ person or _team_ of people
just for running the checkout process in your App/company.
This is where **payment platforms** 
like `Stripe` come into play.
 


## Payment Platforms 😍

Payment platforms **_simplify_ the process of connecting
to multiple third-parties**. 
It offers more than a payment service 
so that merchants only have to liaise with _one_ company 
rather than multiple ones. 

This has a great impact on how an application
is *designed* and *implemented*, 
and allows to for a better management
and 
[decoupling](https://en.wikipedia.org/wiki/Single-responsibility_principle)
of responsibilities.

Instead of our own API having to manage different providers, 
we can use a platform like `Stripe` to do the work for us.
This is how the application should be laid out!

![design](https://user-images.githubusercontent.com/17494745/208956397-cda6d895-8034-45b0-bc91-61befb012fb3.png)

As you can see, it is much simpler!
By offering a bundle of essential payment technologies,
these companies are reducing the merchant's work
of having to manage each of them separately.
In addition to this, there are a number of other advantages,
such as security, data monitoring and reporting.

For example, `Stripe` is like having a multiple
**payment processors**, **payment gateways** and **merchant account**
bundled into one, 
along with a [myriad of other features](https://stripe.com/en-pt).

## `Stripe` 🚀

`Stripe` is considered by many to be 
the [*de facto*](https://trends.builtwith.com/payment/Stripe)
way of accepting credit cards
and electronic payments on the web. 
Beyond collecting card payments 
it has a number of additional features, 
including: 
[smart retries](https://stripe.com/docs/billing/revenue-recovery/smart-retries),
[automatic card updater](https://stripe.com/docs/saving-cards),
[fraud tooling](https://stripe.com/en-gb-pt/radar), 
and other 
[add-ons](https://stripe.com/partners/directory). 

Until we starting to research this in-depth,
we were considering using `Stripe`
because we've used in it previous projects.
But then we discovered ***`Paddle`***!

## `Paddle` 😮

`Paddle` is a new class of payment processor
that includes all additional services 
in their simple fee structure.
Their slogan is: 
"_The better way to sell software_".
Which immediately got our attention 
as that is what we are selling! 

While `Stripe` can be compared to a payment gateway
that deals with multiple channels, 
`Paddle` offers similar features
but acts a *reseller service* - 
**Merchant of Record (MoR)**.

![mor](https://user-images.githubusercontent.com/194400/210158068-92f2ec93-c108-4789-bc03-fd9b34c472bf.png)

A MoR is a term to describe the legal entity
selling goods or services to an end customer:
[paddle.com/blog/what-is-merchant-of-record](https://www.paddle.com/blog/what-is-merchant-of-record) <br />
It's who the end customer owes payment for their purchase,
and it is who handles payments and tax liability for each transaction.
This is great for *tax handling*, 
which is especially relevant in Europe:
[outseta.com/posts/startup-payment-processing](https://www.outseta.com/posts/startup-payment-processing)
and one of the reasons people 
consider `Paddle` in lieu of `Stripe`.
`Stripe` is making strides in also having
better tax compliance: [stripe.com/newsroom/news/taxjar](https://stripe.com/newsroom/news/taxjar)
but it's not quite there,
at the moment of writing.


So businesses can choose to be their own merchant of record
and setup an infrastructure and processes needed to manage
payments with `Stripe` and deal with liabilities
and tax handling themselves.
*Or* they can use MoR service providers like `Paddle`
who take the burden of all of payment processing 
and legal compliance away. Of course, these usually incur higher fees than `Stripe`.

## I'm confused ... Which one should I choose? 🤷‍♀️

That's a great question that has come up before:
[indiehackers.com/post/**stripe-vs-paddle**-89161b0d5c](https://www.indiehackers.com/post/stripe-vs-paddle-89161b0d5c)
`Paddle` themselves have a good comparison:
[paddle.com/**compare/stripe**](https://www.paddle.com/compare/stripe)

Several others have reached the same conclusion, e.g:
[splitbee.io/blog/why-we-moved-from-stripe-to-paddle](https://splitbee.io/blog/why-we-moved-from-stripe-to-paddle)
and
[reddit.com/r/SaaS/comments/q3kao9/paddle_vs_chargebee_vs_stripe_any_recommendations](https://www.reddit.com/r/SaaS/comments/q3kao9/paddle_vs_chargebee_vs_stripe_any_recommendations)

It's still early days for `Paddle`
whereas `Stripe` has several years of head-start:
https://stackshare.io/stackups/paddle-vs-stripe
At present very few companies use `Paddle`,
but those who do are quite vocal about it:



Depending on the use-case or your choice,
each product provides different pricing plans, fees and features
and you should make this decision 
based on the requirements of your project
and how much you are willing to spend.

What's important here is you know
*how online payments work*, 
what parties are involved 
and how you can **leverage these platforms**
to make this process easier. 

Remember, we are dealing with **sensitive information**.
Credit card info should be handled with *extreme caution*
amd these platforms makes it easier for us to do just that.

But implementation-wise,
when designing and implementing your application,
you should notice that 
the process is similar between providers.
Your application will make use of their SDKs
to integrate different channels 
and payment alternatives to process transactions.

And guess what,
we are going to be doing that in the next section!

# How? 💻

The demo/example has quite a few steps,
so we split it out into it's own doc:

