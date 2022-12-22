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
that are [subscription-based](https://www.crunchyroll.com/welcome).
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

## Pre-requisites

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

Make sure you also have 
[`Elixir`](https://elixir-lang.org/)
and [`Phoenix 1.7rc`](https://www.phoenixframework.org/)
installed.

## 1. Create a Phoenix project

Let's start by creating a Phoenix project.
Run `mix phx.new app` 
and when prompted, type `y` to accept downloading the dependencies.

After this, if you run `mix phx.server`
and visit `localhost:4000`, 
you will be able to see the default landing page.

![default](https://user-images.githubusercontent.com/17494745/209141154-a9d88988-6a36-4faa-8bbf-f1cf09684bf5.png)

We will want the user to be able to log in.
We will check if the user has *paid* or not
for using the application. 
If he hasn't, he is redirected to a `buy` page.
If he has, he will have access to it!

It's a simple application, for sure.
But it's still important to know **how** to properly implement it.

## 2. Add `auth_plug` for user login

We will be using 
[`auth_plug`](https://github.com/dwyl/auth_plug)
so users are able to login.

Let's install it.
Add the following to the `deps` section in `mix.exs`.

```elixir
def deps do
  [
    {:auth_plug, "~> 1.5.1"}
  ]
end
```

And run `mix deps.get`.
If you [follow the package instructions](https://github.com/dwyl/auth_plug)
and get your `AUTH_API_KEY`.

Now head over to `lib/app_web/router.ex`
and add the following lines of code.

```elixir
  pipeline :auth, do: plug(AuthPlug)

  scope "/dashboard", AppWeb do
    pipe_through :browser
    pipe_through :auth

    get "/", AppController, :home
  end
```

The `/dashboard` protected endpoint will only be accessible
for logged in users because we are using the 
`:auth` pipeline.

We are using `AppController`, 
which is not yet created. 
Create the following files.

- `lib/app_web/controllers/app_controller.ex`
- `lib/app_web/controllers/app_html.ex`
- `lib/app_web/controllers/app_html/app.html.heex`

Inside `app_html.ex`, add the following code.

```elixir
defmodule AppWeb.AppHTML do
  use AppWeb, :html

  embed_templates "app_html/*"
end
```


Inside `app_controller.ex`, add the following code.

```elixir
defmodule AppWeb.AppController do
  use AppWeb, :controller

  def home(conn, _params) do
    render(conn, :app, layout: false)
  end
end
```

And finally, inside `app_html/app.html.heex`:

```html
<div>
    logged in
</div>
```

Now, if you run:

```sh
export AUTH_API_KEY=XXXX
```

using your `AUTH_API_KEY` 
and restart your server with `mix phx.server`
and access `/dashboard` directly,
you will be redirected to a page where you can SSO using Google or Github.

<img width="1345" alt="redirection" src="https://user-images.githubusercontent.com/17494745/209158781-5242b18f-9abb-4c0c-8703-5be7ed9509f7.png">

After logging in, 
the user has access to the URL!

<img width="686" alt="successful_login" src="https://user-images.githubusercontent.com/17494745/209159171-ee959b68-f4f6-4e69-bf7f-5e0552c1108e.png">

Congratulations, you just added basic authenticated to our application!
However, that's not quite what we want. 
We want the user to be logged in 
and *also* being a paying costumer so they have access to `/dashboard`.

We can make it prettier, though.
Let's add two endpoints:
- one to login (`/login`)
- one to logout (`/logout`)

From the landing page, 
we are going to be adding a button that will log the user in,
and redirect to the `/login` URL.
After logging in, he will be redirected back to the home page.
We will need to conditionally render the home page (`/`)
according to the user being logged in or not.

For this, we are going to be using
an [`optional auth pipeline`](https://github.com/dwyl/auth_plug#optional-auth).
It will add allow us show custom actions on people who are authenticated or not.
This pipeline will add the logged in to the `conn.assigns`.

Head on to `lib/app_web/router.ex` 
and add/change the following piece of code.

```elixir
  pipeline :authoptional, do: plug(AuthPlugOptional, %{})

  scope "/", AppWeb do
    pipe_through :browser
    pipe_through :authoptional

    get "/", PageController, :home
    get "/login", AuthController, :login
    get "/logout", AuthController, :logout
  end
```

We are now using a new controller `AuthController`.
Let's create it.
Inside `lib/app_web/controllers`, 
create a new file called `auth_controller.ex`
and paste the following.

```elixir
defmodule AppWeb.AuthController do
  use AppWeb, :controller

  def login(conn, _params) do
    redirect(conn, external: AuthPlug.get_auth_url(conn, ~p"/"))
  end

  def logout(conn, _params) do
    conn
    |> AuthPlug.logout()
    |> put_status(302)
    |> redirect(to: ~p"/")
  end
end
```

We just now need to change the view
to redirect to these URLs (`login` and `logout`).
Head over to `lib/app_web/controllers/page_html/home.html.heex`,
locate the line.

```html
<div class="px-4 py-10 sm:py-28 sm:px-6 lg:px-8 xl:py-32 xl:px-28">
```

From this line to the end of the file,
change the contents with the next lines:

```html
<div class="px-4 py-10 sm:py-28 sm:px-6 lg:px-8 xl:py-32 xl:px-28">
  <div class="mx-auto max-w-xl lg:mx-0">
    <svg viewBox="0 0 71 48" class="h-12" aria-hidden="true">
      <path
        d="m26.371 33.477-.552-.1c-3.92-.729-6.397-3.1-7.57-6.829-.733-2.324.597-4.035 3.035-4.148 1.995-.092 3.362 1.055 4.57 2.39 1.557 1.72 2.984 3.558 4.514 5.305 2.202 2.515 4.797 4.134 8.347 3.634 3.183-.448 5.958-1.725 8.371-3.828.363-.316.761-.592 1.144-.886l-.241-.284c-2.027.63-4.093.841-6.205.735-3.195-.16-6.24-.828-8.964-2.582-2.486-1.601-4.319-3.746-5.19-6.611-.704-2.315.736-3.934 3.135-3.6.948.133 1.746.56 2.463 1.165.583.493 1.143 1.015 1.738 1.493 2.8 2.25 6.712 2.375 10.265-.068-5.842-.026-9.817-3.24-13.308-7.313-1.366-1.594-2.7-3.216-4.095-4.785-2.698-3.036-5.692-5.71-9.79-6.623C12.8-.623 7.745.14 2.893 2.361 1.926 2.804.997 3.319 0 4.149c.494 0 .763.006 1.032 0 2.446-.064 4.28 1.023 5.602 3.024.962 1.457 1.415 3.104 1.761 4.798.513 2.515.247 5.078.544 7.605.761 6.494 4.08 11.026 10.26 13.346 2.267.852 4.591 1.135 7.172.555ZM10.751 3.852c-.976.246-1.756-.148-2.56-.962 1.377-.343 2.592-.476 3.897-.528-.107.848-.607 1.306-1.336 1.49Zm32.002 37.924c-.085-.626-.62-.901-1.04-1.228-1.857-1.446-4.03-1.958-6.333-2-1.375-.026-2.735-.128-4.031-.61-.595-.22-1.26-.505-1.244-1.272.015-.78.693-1 1.31-1.184.505-.15 1.026-.247 1.6-.382-1.46-.936-2.886-1.065-4.787-.3-2.993 1.202-5.943 1.06-8.926-.017-1.684-.608-3.179-1.563-4.735-2.408l-.043.03a2.96 2.96 0 0 0 .04-.029c-.038-.117-.107-.12-.197-.054l.122.107c1.29 2.115 3.034 3.817 5.004 5.271 3.793 2.8 7.936 4.471 12.784 3.73A66.714 66.714 0 0 1 37 40.877c1.98-.16 3.866.398 5.753.899Zm-9.14-30.345c-.105-.076-.206-.266-.42-.069 1.745 2.36 3.985 4.098 6.683 5.193 4.354 1.767 8.773 2.07 13.293.51 3.51-1.21 6.033-.028 7.343 3.38.19-3.955-2.137-6.837-5.843-7.401-2.084-.318-4.01.373-5.962.94-5.434 1.575-10.485.798-15.094-2.553Zm27.085 15.425c.708.059 1.416.123 2.124.185-1.6-1.405-3.55-1.517-5.523-1.404-3.003.17-5.167 1.903-7.14 3.972-1.739 1.824-3.31 3.87-5.903 4.604.043.078.054.117.066.117.35.005.699.021 1.047.005 3.768-.17 7.317-.965 10.14-3.7.89-.86 1.685-1.817 2.544-2.71.716-.746 1.584-1.159 2.645-1.07Zm-8.753-4.67c-2.812.246-5.254 1.409-7.548 2.943-1.766 1.18-3.654 1.738-5.776 1.37-.374-.066-.75-.114-1.124-.17l-.013.156c.135.07.265.151.405.207.354.14.702.308 1.07.395 4.083.971 7.992.474 11.516-1.803 2.221-1.435 4.521-1.707 7.013-1.336.252.038.503.083.756.107.234.022.479.255.795.003-2.179-1.574-4.526-2.096-7.094-1.872Zm-10.049-9.544c1.475.051 2.943-.142 4.486-1.059-.452.04-.643.04-.827.076-2.126.424-4.033-.04-5.733-1.383-.623-.493-1.257-.974-1.889-1.457-2.503-1.914-5.374-2.555-8.514-2.5.05.154.054.26.108.315 3.417 3.455 7.371 5.836 12.369 6.008Zm24.727 17.731c-2.114-2.097-4.952-2.367-7.578-.537 1.738.078 3.043.632 4.101 1.728.374.388.763.768 1.182 1.106 1.6 1.29 4.311 1.352 5.896.155-1.861-.726-1.861-.726-3.601-2.452Zm-21.058 16.06c-1.858-3.46-4.981-4.24-8.59-4.008a9.667 9.667 0 0 1 2.977 1.39c.84.586 1.547 1.311 2.243 2.055 1.38 1.473 3.534 2.376 4.962 2.07-.656-.412-1.238-.848-1.592-1.507Zm17.29-19.32c0-.023.001-.045.003-.068l-.006.006.006-.006-.036-.004.021.018.012.053Zm-20 14.744a7.61 7.61 0 0 0-.072-.041.127.127 0 0 0 .015.043c.005.008.038 0 .058-.002Zm-.072-.041-.008-.034-.008.01.008-.01-.022-.006.005.026.024.014Z"
        fill="#FD4F00"
      />
    </svg>
    <h1 class="mt-10 flex items-center text-sm font-semibold leading-6 text-brand">
      Phoenix Framework
      <small class="ml-3 rounded-full text-white bg-[#008cdd] px-2 text-[0.8125rem] font-medium leading-6">
        with Stripe
      </small>
    </h1>
    <p class="mt-4 text-[2rem] font-semibold leading-10 tracking-tighter text-zinc-900">
      An example integrating
      <span class="text-[#5d97de]">Stripe</span>
      with
      <span class="text-brand">Phoenix</span>
    </p>
    <p class="mt-4 text-base leading-7 text-zinc-600">
      This is a small project showcasing how to integrate Stripe in a Phoenix project.
      The workflow is simple: a logged in user has to pay to have access to <pre>/dashboard</pre>
    </p>
    <p class="mt-4 text-base leading-7 text-zinc-600">
      Otherwise, they are redirected to a buying page to purchase so they can access it.
    </p>

      <%= if Map.has_key?(@conn.assigns, :person) do %>
        <div class="bg-[#decef633] rounded-lg p-6 mt-4">

          <p class="text-[2rem] font-semibold leading-10 tracking-tighter text-zinc-900">
            Hey there, <%= @conn.assigns.person.username %>!
          </p>
          <p class="mt-4 text-base leading-7 text-zinc-600">
            Thanks for logging in!
            It seems that you haven't purchased our sweet dashboard.
            You have to "purchase" to proceed.
          </p>

          <div class="flex mt-4">
            <div class="w-full sm:w-auto">

              <button class="relative inline-flex items-center justify-center p-0.5 mb-2 mr-2 overflow-hidden text-sm font-medium text-gray-900 rounded-lg group bg-gradient-to-br from-purple-600 to-blue-500 group-hover:from-purple-600 group-hover:to-blue-500 hover:text-white dark:text-white focus:ring-4 focus:outline-none focus:ring-blue-300 dark:focus:ring-blue-800">
                <span class="relative px-5 py-2.5 transition-all ease-in duration-75 bg-white dark:bg-gray-900 rounded-md group-hover:bg-opacity-0">
                    Purchase
                </span>
              </button>
              <.link
                navigate={~p"/logout"}
                class="text-purple-700 font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2"
              >
                Logout
              </.link>
            </div>
          </div>

        </div>
      <% else %>
        <div class="flex">
          <div class="w-full sm:w-auto">
            <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-3">
              <.link
                navigate={~p"/login"}
                class="text-white bg-gradient-to-br from-pink-500 to-orange-400
                hover:bg-gradient-to-bl
                focus:ring-4 focus:outline-none focus:ring-pink-200 dark:focus:ring-pink-800
                font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2"
              >
                Login
              </.link>
            </div>
          </div>
        </div>
      <% end %>
  </div>
</div>
```

And you should be done!
The app should look like the following.

![with_auth](https://user-images.githubusercontent.com/17494745/209171533-2a51572b-2d0f-4789-a28b-7d77771caaa5.gif)

Now that we got that out of the way,
we can now *focus on integrating `Stripe`*
in our Phoenix application.

This is going to be fun, let's do this! 👏

## 3. Stripe integration


# Thanks!

Thanks for learning about payment processing with us!
If you have any questions, please ask!!
Please ⭐ this repo to help spread the word!

If you are using environment variables in a way not mentioned in this readme, or have a better way of managing them or any other ideas or suggestions for improvements please tell us!!