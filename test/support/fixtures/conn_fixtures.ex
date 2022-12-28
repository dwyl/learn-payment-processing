defmodule App.ConnFixtures do
  @moduledoc """
  This module defines test helpers for creating
  conn connections with associated data
  """

  @person_id 1

  @doc """
  Generate a connection with a logged in user.
  """
  def setup_conn_with_user(conn) do
    new_assigns = %{
      person: %{
        app_id: 5,
        aud: "Joken",
        auth_provider: "github",
        email: "test@email.com",
        exp: 1_702_132_323,
        iat: 1_670_595_323,
        id: @person_id,
        iss: "Joken",
        jti: "2snib63q7a9l9sfmdg00117h",
        nbf: 1_670_595_323,
        sid: 1,
        username: "test_username",
        picture: "this",
        givenName: "John Doe"
      },
      loggedin: true
    }

    new_assigns =
      Map.put(
        new_assigns,
        :jwt,
        AuthPlug.Token.generate_jwt!(%{
          username: "test_username",
          email: "test@email.com",
          givenName: "John Doe",
          picture: "this",
          auth_provider: "GitHub",
          sid: 1,
          id: @person_id
        })
      )

    Map.replace(conn, :assigns, new_assigns)
  end
end
