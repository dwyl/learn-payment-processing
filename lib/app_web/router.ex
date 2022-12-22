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

  scope "/", AppWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/dashboard", AppWeb do
    pipe_through :browser
    pipe_through :auth

    get "/", AppController, :home
  end
end
