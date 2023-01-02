
# Let's Build! 💻

In this section, 
we are going to be implementing an example application
using `Stripe` with `Elixir`.



> If you have never programmed in `Elixir`,
we recommend checking the 
[`learn-elixir`](https://github.com/dwyl/learn-elixir) 
and [`learn-phoenix-framework`](https://github.com/dwyl/learn-phoenix-framework)
repositories before you start this walk-through,
as we are going to be focusing on payment processing,
and not on the basics of a `Phoenix` project. 

The reason we went with `Stripe` 
and not any other alternative like `Paddle` 
is because `Stripe` allows us to create an account
without having to fill business-related information,
KYC and a company website.

We are going to see how far we can get with `Stripe`
and document the process.
If we decide we _need_ the features/simplicity 
offered by `Paddle` we will switch and document that too.

## Pre-requisites 📝

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

<img width="1345" alt="keys" src="https://user-images.githubusercontent.com/17494745/208983428-c75a0df2-a088-40fe-a68c-3193c829a3a4.png">

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

Now, you can create a local file 
called `.env` 
(don't forget to **never commit this file**, 
as it contains sensitive information and API keys)
and paste the following.

```sh
export AUTH_API_KEY=XXXX
```

If you run `source .env` 
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
In our main page we are checking if any user is logged in or not.
If there's a user authenticated, 
we show his username and a button in which he can press
to purchase our sweet dashboard.

On the other hand, if there isn't any user authenticated, 
a `login` button is shown.

The app should look like the following.

![with_auth](https://user-images.githubusercontent.com/17494745/209171533-2a51572b-2d0f-4789-a28b-7d77771caaa5.gif)

Now that we got that out of the way,
we can now *focus on integrating `Stripe`*
in our Phoenix application.

This is going to be fun, let's do this! 👏

## 3. Stripe integration

Let's start by installing the package
that will allows us to communicate with **Stripe**.
We are going to be using 
[`stripity-stripe`](https://github.com/beam-community/stripity-stripe).
This library will allow us to easily integrate Stripe in our Phoenix application.

Go to your `mix.exs` file
and add this inside your dependency section.

```elixir
{:stripity_stripe, "~> 2.17"}
```

and run `mix deps.get` to fetch this new dependency.
Following [their documentation](https://github.com/beam-community/stripity-stripe#configuration),
we need to add the next configuration inside `config.ex`.

```elixir
config :stripity_stripe, api_key: System.get_env("STRIPE_API_KEY")
```

As you can see, we are using an environment variable
to serve the `STRIKE_API_KEY` so the library can use it to make requests.
We need to add these keys to our `.env` file.
To check your own API keys, 
go to https://dashboard.stripe.com/test/apikey

<img width="1345" alt="keys" src="https://user-images.githubusercontent.com/17494745/208983428-c75a0df2-a088-40fe-a68c-3193c829a3a4.png">

and paste the keys in your `.env` file.

```
export STRIPE_API_KEY= secret key
export STRIPE_PUBLIC= publishable key
```

After inputting these keys, 
you can stop the server and,
in the same terminal session, run `source .env`,
so you can load these environment variables
and so they are available when you run `mix phx.server` again.

Awesome job! 🎉
We can now start using it!

### 3.1 Creating a **Stripe Checkout Session**

To make this tutorial simple, 
we are going to be using a [`Stripe Checkout`](https://stripe.com/docs/payments/checkout).
This makes it easy to make a payment 
because the user is redirected to a page hosted by `Stripe` 
with information about the product being purchased. 
Therefore, we don't need to create the page ourselves.
We *could* but this is quicker 😉.

With this in mind, 
we want to create a [`checkout session`](https://stripe.com/docs/api/checkout/sessions).
The user will either be successful with his payment
or fail. 
We will be building a page for both.

Let's implement this.

Head on to to `lib/app_web/router.ex`
and add the following scope.

```elixir
  scope "/purchase", AppWeb do
    pipe_through :browser
    pipe_through :auth

    resources "/checkout-session", CheckoutSessionController, only: [:create]

    get "/success", PageController, :success
    get "/cancel", PageController, :cancel
  end
```

We want **only authenticated users** to go to
`/purchase/checkout-session` to purchase our product.
When they visit this URL, they will be redirected to our `Stripe Checkout` page,
with information about our product.
They payment will either *succeed* 
(users will be redirected to `/purchase/success`)
or *fail*
(users will be redirected to `/purchase/cancel`).

While the `success` and `cancel` pages 
are being handled by the already existent `PageController`,
redirecting the users to the `Stripe Checkout` page 
is being handled by `CheckoutSessionController`. 
We need to create it!

Inside `lib/app_web/controllers/`, 
create a file called `checkout_session_controller.ex`
and paste the code:

```elixir
defmodule AppWeb.CheckoutSessionController do
  use AppWeb, :controller

  def create(conn, _params) do
    url = AppWeb.Endpoint.url()

    params = %{
      line_items: [
        %{
          price: System.get_env("PRODUCT_PRICE_ID"),
          quantity: 1
        }
      ],
      mode: "payment",
      # https://stripe.com/docs/payments/checkout/custom-success-page
      success_url: url <> ~p"/purchase/success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: url <> ~p"/purchase/cancel?session_id={CHECKOUT_SESSION_ID}",
      # user_email: conn.assigns.person.email,
      automatic_tax: %{enabled: true}
    }

    {:ok, session} = Stripe.Session.create(params)

    conn
    |> put_status(303)
    |> redirect(external: session.url)
  end
end
```

Let's analyze the code.

We are using `Stripe.session.create/1` 
to create a [`Session`](https://stripe.com/docs/api/checkout/sessions)
in Stripe. 
We need to pass a few required parameters. 
We are following [their API specification](https://stripe.com/docs/api/checkout/sessions/object),
so you can always check their documentation if you're lost
on what fields you need to pass.
- the `**mode**` field pertains to the mode of the checkout session.
We can setup subscription or one-time payments.
We are doing the latter.
- the `**success_url**` and `**cancel_url**` refer to the redirection URLs
after the user either completes or cancels the checkout session.
We are adding a `{CHECKOUT_SESSION_ID}` template in the URL.
This tells Stripe to pass the `Checkout Session ID` to the client-side.
[This will allow us to customize the order information
upon completion or cancellation.](https://stripe.com/docs/payments/checkout/custom-success-page)
- we set `**automatic_tax**` to be enabled so it makes tax conversions automatically.
- the `**line_items**` array refer to the list of items the customer is purchasing.
We are passing the item `id` and the `quantity`.
- you can optionally pass a `customer_email`, 
so the field is already defined within the checkout session from the get-go.

We are then creating a session 
and redirecting the user to the `Checkout` page.

As you might have noticed, 
we are using an environment variable `PRODUCT_PRICE_ID`
to set `price` field of the product.

We *haven't created this yet*.
So let's do it!

### 3.2 Creating a `Product` to sell

As it stands, we have no products for customers to purchase.
Let's create one! 😎

Go to https://dashboard.stripe.com/test/products/create
and fill up the information about your product.


<img width="1239" alt="product_information" src="https://user-images.githubusercontent.com/17494745/209212460-b04c1ab0-0f6c-4365-b634-b6788d9aaffc.png">

> This should be all you need to do.
However, sometimes you may experience an error
while creating a `checkout session` 
when doing the request in Phoenix.
>
> The error is probably 
`Stripe Tax has not been activated on your account. 
Please visit https://dashboard.stripe.com/settings/tax/activate to get started.`
Don't be alarmed.
If you follow the link, enable `Stripe Tax`
and just create a tax rate on whatever country you want,
You can check your tax rates in 
https://dashboard.stripe.com/test/tax-rates.
>
> <img width="1350" alt="image" src="https://user-images.githubusercontent.com/17494745/209214128-e199279d-a3b6-4f99-9184-8417369e0af8.png">

After creating your product,
you will be redirected to the page of the product created.
You can always check the products you created 
in https://dashboard.stripe.com/test/products.

The page of the product created should look like this.

<img width="1239" alt="product page" src="https://user-images.githubusercontent.com/17494745/209214262-24dc0852-7a78-46d3-a907-368ce4bab2b6.png">

We are going to be using the `API ID` 
in the Pricing section. 
Copy it and paste it in your `.env` file.

```
export PRODUCT_PRICE_ID= price id
```

In the same terminal session, kill the server,
run `source .env` and you should be good to go!

### 3.3 Success and failure after `Checkout Session`

As we've stated before, 
the users are redirected to a `success` or `cancel` page
depending on the outcome of the `Checkout Session`.

Since we defined these endpoints 
be controlled by `PageController`, 
we need to add these handlers.

Go to `lib/app_web/controllers/page_controller.ex`
and add the following piece of code:

```elixir
  def success(conn, %{"session_id" => session_id}) do
    case Stripe.Session.retrieve(session_id) do
      {:ok, _session} ->
        render(conn, :success, layout: false)

      {:error, _error} ->
        conn
        |> put_status(303)
        |> redirect(to: ~p"/")
    end
  end

  def success(conn, _params) do
    conn
    |> put_status(303)
    |> redirect(to: ~p"/")
  end

  def cancel(conn, %{"session_id" => session_id}) do

    case Stripe.Session.retrieve(session_id) do
      {:ok, _session} ->
        render(conn, :cancel, layout: false)

      {:error, _error} ->
        conn
        |> put_status(303)
        |> redirect(to: ~p"/")
    end
  end

  def cancel(conn, _params) do
    conn
    |> put_status(303)
    |> redirect(to: ~p"/")
  end
```

Let's break it down.

When creating a session, 
we are requesting Stripe to redirect the user
*back* to us with a query parameter `session_id`
with the session ID.

This `session_id` will allow us to 
conditionally render these pages according to the outcome
of the process.

Both `success` and `cancel` workflows have the same workflow.

When the customer successfully pays for the product,
we check if the `session_id` is valid 
by retrieving it from `Stripe`.

```elixir
Stripe.Session.retrieve(session_id)
```

If it is successful, we render a page confirming the payment.
If it is not, we simply redirect the user to the homepage.
If the user tries to directly access `/purchase/success`,
he is redirected to the homepage as well.

The same procedure happens in the `cancel` scenario.

We now need to create these pages!
Inside `lib/app_web/controllers/page_html`,
create two files.
Create `success.html.heex` 
and use this code:

```html
<div class="bg-gray-100 h-screen flex flex-col justify-center items-center">
    <div class="p-6  md:mx-auto">
        <svg viewBox="0 0 24 24" class="text-green-600 w-16 h-16 mx-auto my-6">
            <path fill="currentColor"
                d="M12,0A12,12,0,1,0,24,12,12.014,12.014,0,0,0,12,0Zm6.927,8.2-6.845,9.289a1.011,1.011,0,0,1-1.43.188L5.764,13.769a1,1,0,1,1,1.25-1.562l4.076,3.261,6.227-8.451A1,1,0,1,1,18.927,8.2Z">
            </path>
        </svg>
        <div class="text-center">
            <h3 class="md:text-2xl text-base text-gray-900 font-semibold text-center">Payment Done!</h3>
            <p class="text-gray-600 my-2">Thank you for completing your secure online payment.</p>
            <p> Have a great day!  </p>
            <div class="py-10 text-center">
                <.link
                  href={~p"/dashboard"}
                  class="px-12 bg-indigo-600 hover:bg-indigo-500 text-white font-semibold py-3"
                >
                  Go to dashboard
                </.link>
            </div>
        </div>
    </div>
</div>
```

In this page, we are thanking the user
for completing the payment 
and giving him the option to access
the ever so glorious ✨**dashboard**✨.

In the same directory,
create the `cancel.html.heex` file:

```elixir
<section class="flex items-center h-screen p-16">
	<div class="container flex flex-col items-center justify-center px-5 mx-auto my-8">
		<div class="max-w-lg text-center">
			<h2 class="mb-8 font-extrabold text-9xl dark:text-gray-600">
				Oh no...
			</h2>
			<p class="text-2xl font-semibold md:text-3xl">looks like something went wrong.</p>
			<p class="mt-4 mb-8 dark:text-gray-400">Perhaps you cancelled your order? Internet went down? We can help you get back on track!</p>
            <.link
                href={~p"/"}
                class="px-8 py-3 font-semibold rounded text-white bg-violet-400"
            >
                Back to homepage
            </.link>
		</div>
	</div>
</section>
```

In this page, 
we state that something went wrong 
and show a button to return to the homepage.

### 3.4 Making our "`dashboard`" cool

We don't really have a `dashboard` to show.
In fact, we don't need to, it's out of the scope of this tutorial.
So let's just show a Nyan Cat! 🐈

Inside `lib/app_web/controllers/app_html/app.html.heex`,
change the code to the following:

```elixir
<div class="bg-bottom h-screen flex flex-col justify-center items-center">
    <img src="https://raw.githubusercontent.com/gist/brudnak/aba00c9a1c92d226f68e8ad8ba1e0a40/raw/e1e4a92f6072d15014f19aa8903d24a1ac0c41a4/nyan-cat.gif"
            alt="Nyan cat"
            class="max-w-[60%]"
            />
    <div class="text-center">
        <h3 class="md:text-5xl text-base text-gray-900 font-semibold text-center">Nyan Cat!</h3>
        <p class="text-gray-600 my-2">Yup, it's a nyan cat. It's not a dashboard.</p>
        <p class="text-gray-400 mt-12 mb-12">sorry.</p>

        <.link
            navigate={~p"/"}
            class="text-white bg-gradient-to-r from-blue-500 via-blue-600 to-blue-700 hover:bg-gradient-to-br
            focus:ring-4 focus:outline-none focus:ring-blue-300 dark:focus:ring-blue-800 shadow-lg
            shadow-blue-500/50 dark:shadow-lg dark:shadow-blue-800/80 font-medium rounded-lg text-sm px-5 py-2.5 text-center mr-2 mb-2 "
            >
            go back
        </.link>
    </div>
</div>
```

All that's left is for the `Purchase` button
in our homepage to redirect the user
to the `/purchase/checkout-session`
for the customer to pay for the product.

Inside `lib/app_web/controllers/page_html/home.html.heex`,
locate the line:

```html
<span class="relative px-5 py-2.5 transition-all ease-in duration-75 bg-white dark:bg-gray-900 rounded-md group-hover:bg-opacity-0">
    Purchase
</span>
```

And replace it with:

```html
<.link
  href={~p"/purchase/checkout-session"}
  method="post"
  class="relative px-5 py-2.5 transition-all ease-in duration-75 bg-white dark:bg-gray-900 rounded-md group-hover:bg-opacity-0"
>
  Purchase
</.link>
```

And you should be done! 🎉

Let's see what we've done so far.
Run `mix phx.server` 
(make sure you loaded the env variables
with `source .env`) 
and visit `localhost:4000`.
You should see the following! 👏

![stripe_integrated](https://user-images.githubusercontent.com/17494745/209217397-4b1c1cb4-6777-4ca0-998e-b860030642a8.gif)

> You can complete the payment 
using test data with the credit card.
You can fill whatever e-mail address (real or not)
or name to pay. 
The expiry date and CVC can also be random.
>
> - Payment succeeds: `4242 4242 4242 4242`
> - Payment requires authentication: `4000 0025 0000 3155`
> - Payment is declined: `4000 0000 0000 9995`

You can check the customers info in 
https://dashboard.stripe.com/test/customers.
You may delete the customers, if you want.

<img width="1214" alt="users" src="https://user-images.githubusercontent.com/17494745/209217798-ffd4a694-947d-4aad-ac20-cbcdf1c56143.png">

## 4. Blocking unpaid users from `dashboard`

We now got a decent workflow going.
But authenticated can still access `/dashboard`
while just being authenticated.
We want them to be logged in 
*and also have paid to access it*.

We are currently not tracking our customers
who have paid and should be granted access.
We are going to be needing to create
a way to save `User`s object 
with the referring `stripe_id` 
and a boolean field referring to the payment status.

We could use a PostgresSQL engine for this,
but for this use case it's a bit overkill.
Instead, to simplify deployment,
we will be using 
[`Erland Term Storage (ETS)`](https://elixirschool.com/en/lessons/storage/ets).
This is a in-memory storage engine built into OTP 
and can be employed to store large amounts of data 
*with constant time data access*.
Do note that since this engine is in-memory,
**all data is lost when the process ends/server is shutdown**.

There is an Elixir wrapper that makes it easy to use `ETS` and `DETS`, 
where the latter is a disk-based variant of the former,
where data is persisted on disk.
We'll be using
[`pockets`](https://github.com/fireproofsocks/pockets).

Let's install it.

Add it to the `deps` section inside `mix.exs`.

```elixir
def deps do
  [
    {:pockets, "~> 0.1.0"}
  ]
end
```

With that installed, 
we are going to be creating a module 
that will *manage the users table*.
We are going to create it on startup,
and create users/edit them.

For that, create a file in `lib/app/users.ex`.

```elixir
defmodule UsersTable do

  alias Pockets

  @table :users_table
  @filepath "cache.dets"

  def init do
    case Pockets.new(@table, @filepath) do
      {:ok, set} -> {:ok, set}
      {:error, _} ->
        Pockets.open(@table, @filepath)
    end
  end

  def create_user(%{:stripe_id => stripe_id, :person_id => person_id, :status => status}) do
    Pockets.put(@table, person_id, %{stripe_id: stripe_id, status: status})
  end

  def fetch_user(person_id) do
    Pockets.get(@table, person_id)
  end

end
```

Let's go over what we have done.
We are going to be saving our users
with a tuple containing the `**stripe_id**`,
the `person_id` of the logged in user
and a `**status**` boolean field,
referring to whether the user has paid or not.

All the functions being used are used
according to the [`ets` wrapper documentation](https://github.com/TheFirstAvenger/ets).
- the `init/0` function creates the table to store our users.
If the file already exists, we open the file.
- `create_user/3` receives a `stripe_id`, `person_id` and `status` 
(pertaining to whether the payment has been made or not)
and creates a user object.
- `fetch_user/1` retrieves the persisted user
according to the given` person_id`.

Let's make use of some of these functions.
We want to setup the `DETS` table on the process startup.
For this, we are going to initiate the table
on the `start/1` function inside `lib/app/application.ex`.
This function is executed when the process is created,
so it fits right our needs!
Add the following code below the `children` array variable
inside `start/1`.

```elixir
UsersTable.init()
```

We now need to **create the user** every time 
a Stripe session is successful. 
We can do this inside `lib/app_web/controllers/page_controller.ex`
on the `success/2` callback.
Change the handler, so it looks like the following:

```elixir
def success(conn, %{"session_id" => session_id}) do

  case Stripe.Session.retrieve(session_id) do
    {:ok, session} ->

      person_id = conn.assigns.person.id
      UsersTable.create_user(%{person_id: person_id, stripe_id: session.customer, status: true})

      render(conn, :success, layout: false)

    {:error, _error} ->
      conn
      |> put_status(303)
      |> redirect(to: ~p"/")
  end
end
```

Now, inside `lib/app_web/controllers/app_+controller.ex`,
we will render our "dashboard"
**only** if a user is found in our `Users` table.
If there isn't a user found, we redirect the user to the homepage.
Change the `home/2` function so it looks like the following.

```elixir
def home(conn, _params) do

  person_id = conn.assigns.person.id
  case UsersTable.fetch_user(person_id) do
    nil ->
      conn |> redirect(to: ~p"/")

    _ ->
      render(conn, :app, layout: false)
  end
end
```

All there's left to do 
is to change the `Purchase` button to dynamically change.
We want paid users to access the dashboard directly,
and non-paid users to purchase it.

To do this, add this function
in `lib/app_web/controllers/page_html.ex`.

```elixir
  def check_user_has_paid(person_id) do
    user = UsersTable.fetch_user(person_id)

    if user == nil, do: false, else: user.status
  end
```

Inside `lib/app_web/controllers/page_html/home.html.heex`,
change the `Purchase` button so it changes according to the user's payment status.

```html
<%= if check_user_has_paid(@conn.assigns.person.id) do %>
    <.link
      href={~p"/dashboard"}
      class="relative px-5 py-2.5 transition-all ease-in duration-75 bg-white dark:bg-gray-900 rounded-md group-hover:bg-opacity-0"
    >
      Enter
    </.link>
  <% else %>
    <.link
      href={~p"/purchase/checkout-session"}
      method="post"
      class="relative px-5 py-2.5 transition-all ease-in duration-75 bg-white dark:bg-gray-900 rounded-md group-hover:bg-opacity-0"
    >
      Purchase
    </.link>
  <% end %>
```

## 5. All done! 🎉

And you should be done!
The user can now pay for our product.
We are restricting user access for only users that have paid.
Users that *have* made the payment **will have access**.

![final](https://user-images.githubusercontent.com/17494745/209818299-f9a1a197-6ef8-4e2e-b1be-960b6df88d1b.gif)


# Thanks!

Thanks for learning about payment processing with us!
If you have any questions, please ask!!
Please ⭐ this repo to help spread the word!

If you are using environment variables in a way not mentioned in this guide, 
or have a better way of managing them 
or any other ideas or suggestions for improvements 
please tell us!!