defmodule AppWeb.AppController do
  use AppWeb, :controller

  def home(conn, _params) do

    person_id = conn.assigns.person.id
    case UsersTable.fetch_user(person_id) do
      nil ->
        conn |> redirect(to: ~p"/")

      _ ->
        render(conn, :app, layout: false)
    end
  end
end
