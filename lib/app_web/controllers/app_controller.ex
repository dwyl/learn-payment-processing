defmodule AppWeb.AppController do
  use AppWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :app, layout: false)
  end
end
