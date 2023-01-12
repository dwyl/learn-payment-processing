defmodule AppWeb.PageHTML do
  use AppWeb, :html

  embed_templates "page_html/*"

  def check_user_has_paid(person_id) do
    user = UsersTable.fetch_user(person_id)

    if user == nil, do: false, else: user.status
  end
end
