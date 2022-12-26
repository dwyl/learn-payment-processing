defmodule AppWeb.PageController do
  use AppWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end

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
end
