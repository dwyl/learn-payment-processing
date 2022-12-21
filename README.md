<div align="center">

# Learn Payment Processing

![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/dwyl/learn-payment-processing/ci.yml?label=build&style=flat-square&branch=main)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/learn-payment-processing/main.svg?style=flat-square)](https://codecov.io/github/dwyl/phoenix-chat-example?branch=main)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/phoenix-chat-example/issues)  
[![HitCount](https://hits.dwyl.com/dwyl/learn-payment-processing.svg?style=flat-square&show=unique)](http://hits.dwyl.com/dwyl/learn-payment-processing)
  
Learn what payment processing is 
and how you can add it to your application!

</div>

# Why? 🤷

Not all applications are free.
There are some that can be acquired through
a [one time purchase](https://git-fork.com/buy).
There are others
that are [subscription-based](https://www.notion.so/pricing).
Regardless of the type, all of these share one thing in common:
**they use payment processing platforms/gateways
to manage transactions**.

In any current application, 
knowing how processing payments *work*
and how they *can* be implemented 
is important, 
as it affects the bottom-line
of the project/application/company. 

# What 💭

Let's think for a minute of what happens
when we purchase something online.
Assume we want to [buy Fork](https://git-fork.com/buy), 
a neat open-source Git GUI. 

<img width="1198" alt="buy-fork-1" src="https://user-images.githubusercontent.com/17494745/208933958-8747bf88-cd74-4ec1-8739-430fdb1874ab.png">

If we click the `Buy Fork` button,
we are met with a modal 
for a one-time purchase license.

<img width="1198" alt="buy-fork-modal" src="https://user-images.githubusercontent.com/17494745/208934931-e5dedff8-5852-49bf-afe3-55d4f8ea9649.png">

If we proceed to payment, 
we can pay through Paypal
or Apple Pay
or even with any credit-card!

<img width="1198" alt="buy-fork-options" src="https://user-images.githubusercontent.com/17494745/208935302-d7c724a8-cc1c-4026-9743-83c8a25066f6.png">

But how was this implemented?
Is there any service behind this?
For those with a keen eye, 
you might have noticed 
that in the lower third of the screen,
it seems that this transaction
is being handled by 
[`Paddle.com`](https://www.paddle.com/).

`Paddle.com` can be described as a
*payment infrastructure provider*
that takes care of transactions 
and payments made by the users of your application
and facilitates integrating payments to your application.
By using these types of services,
it is much easier for *us* developers
to provide different ways of users to pay
and integrate payments *seamlessly* in our applications.

But, as you may be aware, 
there are several other SaaS providers,
such as [`Stripe`](https://stripe.com/en-pt)
or [`Square`](https://squareup.com/us/en/).
Each one of these may differ from each others. 

But we are getting ahead of ourselves.
We need to clarify some concepts before moving forward.

Ready to start? 🏁

## How payment works

Let's start with an analogy.
Imagine you want to send a parcel to your father.
1. You first drop it in a DHL (or UPS) drop-off point.
2. DHL collects the package and transports the parcel to your father.
3. Once the delivery is complete, 
a confirmation e-mail is sent to you and your father.

Think of the DHL distribution network
as analogous to a **payment processor**.
And think of the drop-off point 
as a **payment gateway**. 
To make an online payment,
customers create a transaction
*via payment gateway*
and the *payment processor facilitates communication
between parties* and transfers funds
into the merchant's bank account.

<img width="1278" alt="gateway_v_processor" src="https://user-images.githubusercontent.com/17494745/208946952-4da1600e-9936-4491-9a6e-a5a7e09c023c.png">

So, a **payment processor** functions as an intermediary
between the customer's party 
(which consists of the user and his bank)
and the merchant's
(which consists of the merchant and his bank).
It is the entity responsible for communicating
between both parties in the transaction.

Meanwhile, the **payment gateway**
is a *point of sale* for online payments.
Similarly to when a customer swipes his card
on a physical credit card terminal,
online stores need a gateway to securely collect
the customer's payment information. 
So *payment gateway is basically a virtual terminal,
and functions as a point of sale*.

This whole process of online payment
usually assumes the merchant
has a [**merchant account**](https://www.investopedia.com/terms/m/merchant-account.asp).
A merchant account is simply
a type of business bank account
that *allows a business
to receive credit card 
and electronic transactions*.

Do note that the terms `"payment processor"` and `"payment gateway"` 
usually fall under the same term - `payment processor`. 
This is because they work together in achieving 
the payment processing. 
So if you see platforms like `Stripe` 
being mentioned as a "payment processor",
it's because it offers both `payment gateway` and `payment processor` 
bundled together (alongside a myriad of other features).

## Okay... but where does `Paddle` come into all of this?

Now that we got the important concepts out of the way,
you might be wondering:
"That's cool, but what does this have to do 
with the `Paddle` example you gave earlier?"

Glad you asked! 👍

If you've done online shopping before,
you probably came across a button like this,
which allowed you to purchase the item through Paypal.

![paypal](https://user-images.githubusercontent.com/17494745/208951049-421e123a-e082-433e-8b08-60c7da8c8a57.png)

If you wanted to add a way for users to purchase
an item in your application through Paypal,
you'd have to setup a Paypal account
and use [one of their SDKs](https://developer.paypal.com/home)
to make it possible for customers to buy
through Paypal.

You are basically using the [Paypal E-commerce platform](https://www.paypal.com/us/business/platforms-and-marketplaces)
to setup a payment gateway and processor
for users to pay with Paypal on your site.

Awesome! 🎉

Let's say you now want to add 
[`Google Pay`](https://pay.google.com/about/business/implementation/), 
as a payment method, as well.
You'd have to create an account,
use [their SDK](https://developers.google.com/pay/api)
and integrate it in your website.

We shouldn't forget iPhone users as well!
We also want (need!) to add an [`Apple Pay`](https://www.apple.com/apple-pay/)
payment method to our application.
Same procedure occurs, we ought to create an account
and use [their SDK](https://developer.apple.com/apple-pay/implementation/)
to integrate it into our application.

On top of this, we need to create our own merchant account
so each one of these services can connect to it
and process the transactions.

This is a heap of effort 
and can easily scale to unsustainable levels.
This is where **payment platforms** 
like Stripe come into play.

## Payment platforms

Payment platforms **simplify the process of connecting
to multiple third-parties**. 
It offers more than a payment service 
so that merchants only have to liaise with one company 
rather than multiple ones. 

This has a great impact on how an application
is *designed* and *implemented*, 
and allows to for a better management
and [decoupling](https://en.wikipedia.org/wiki/Single-responsibility_principle)
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

## Stripe and alternatives

`Stripe` is considered by many to be 
the [*de facto*](https://trends.builtwith.com/payment/Stripe)
way of accepting credit cards
and electronic payments on the web. 
It's a powerful payment tool 
that has a number of additional features, 
including [smart retries](https://stripe.com/docs/billing/revenue-recovery/smart-retries),
[automatic card updater](https://stripe.com/docs/saving-cards),
[fraud tooling](https://stripe.com/en-gb-pt/radar), 
and [others](https://stripe.com/partners/directory). 

However, it is important to note that there are
several other options that do offer similar features,
ease of payment integration into your application 
but handle payments in a different way.

For example, `Paddle`, as we have mentioned earlier,
works on a completely different way.
While `Stripe` can be compared to a payment gateway
that deals with multiple channels, 
`Paddle` offers similar features
but acts a *reseller of your services* - 
**merchant of record (MoR)**.

A MoR is ["a term to describe the legal entity
selling goods or services to an end customer"](https://www.paddle.com/blog/what-is-merchant-of-record).
It's who the end customer owes payment for their purchase,
and it is who handles payments and liability for each transaction.
This is great for *tax handling*, 
[which is especially relevant in Europe](https://www.outseta.com/posts/startup-payment-processing)
and one of the reasons people 
[consider `Paddle` in lieu of `Stripe`](https://splitbee.io/blog/why-we-moved-from-stripe-to-paddle).
`Stripe` is making strides in also having
[better tax compliance](https://stripe.com/newsroom/news/taxjar)
but it's not quite there, at the moment of writing.

![mor](https://images.prismic.io/paddle/d6ff57bb-31dd-41ed-86c6-23d73584b617_merchant+of+record.png?auto=format&fit=crop&ixlib=react-9.5.4)

So businesses can choose to be their own merchant of record
and setup an infrastructure and processes needed to manage
payments with `Stripe` and deal with liabilities
and tax handling themselves.
*Or* they can use MoR service providers like `Paddle`
who take the burden of all of payment processing 
and legal compliance away. Of course, these usually incur higher fees than `Stripe`.

## I'm confused. Which one should I choose?

[That's a great question](https://www.indiehackers.com/post/stripe-vs-paddle-89161b0d5c).

[Which seems to asked](https://splitbee.io/blog/why-we-moved-from-stripe-to-paddle)
[over](https://stackshare.io/stackups/paddle-vs-stripe),
and [over](https://www.paddle.com/compare/stripe)
and [over](https://www.reddit.com/r/SaaS/comments/q3kao9/paddle_vs_chargebee_vs_stripe_any_recommendations/) again.

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
the process is similar between whatever alternative you choose.
Your application will make use of their SDKs
to integrate different channels 
and payment alternatives to process transactions.

And guess what,
you are going to be doing that in the next section!

Race you there! 🏃

# How? 💻

In this section, 
we are going to be implementing an example application
using Stripe with Elixir.

> If you have never programmed in Elixir,
we recommend checking the 
[`learn-elixir`](https://github.com/dwyl/learn-elixir) 
and [`learn-phoenix-framework`](https://github.com/dwyl/learn-phoenix-framework)
repositories before you start this walk-through,
as we are going to be focusing on payment processing,
and not on the basics of a Phoenix project. 

The reason we went with `Stripe` 
and not any other alternative like `Paddle` 
is because `Stripe` allows us to create an account
without having to fill business-related information,
KYC and a company website.

# Pre-requisites

For this tutorial,
you will need to create a `Stripe` account.
If you visit https://dashboard.stripe.com/register,
you will be prompted to create an account.

<img width="1345" alt="stripe-create" src="https://user-images.githubusercontent.com/17494745/208978760-84f42dfd-7eee-4363-b250-6dcca0ee90b7.png">

After filling your information,
and verifying your account, 
you will be able to access the main dashboard.
If you type "API" inside the search box 
and choose `Developers > API Keys`...

<img width="1345" alt="dashboard" src="https://user-images.githubusercontent.com/17494745/208983008-93f34198-3d0e-4d7b-a493-ccbe87afa5b6.png">

You will be prompted with the following window.

<img width="1345" alt="Screenshot 2022-12-21 at 19 02 28" src="https://user-images.githubusercontent.com/17494745/208983428-c75a0df2-a088-40fe-a68c-3193c829a3a4.png">

These API keys will later be used in the tutorial.
Save them and don't show them to anyone else!
We are going to be using these
as [environment variables](https://github.com/dwyl/learn-environment-variables).

# Thanks!

Thanks for learning about payment processing with us!
If you have any questions, please ask!!
Please ⭐ this repo to help spread the word!

If you are using environment variables in a way not mentioned in this readme, or have a better way of managing them or any other ideas or suggestions for improvements please tell us!!