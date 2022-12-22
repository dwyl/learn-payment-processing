defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {AppWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :auth, do: plug(AuthPlug)
  pipeline :authoptional, do: plug(AuthPlugOptional, %{})

  scope "/", AppWeb do
    pipe_through :browser
    pipe_through :authoptional

    get "/", PageController, :home

    get "/login", AuthController, :login
    get "/logout", AuthController, :logout

  end

  scope "/purchase", AppWeb do
    pipe_through :browser
    pipe_through :auth

    resources "/checkout-session", CheckoutSessionController, only: [:create]

    get "/success", PageController, :success
    get "/cancel", PageController, :cancel
  end


  scope "/dashboard", AppWeb do
    pipe_through :browser
    pipe_through :auth

    get "/", AppController, :home
  end
end
