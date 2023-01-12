defmodule AppWeb.CheckoutSessionController do
  use AppWeb, :controller

  def create(conn, _params) do
    url = AppWeb.Endpoint.url()

    params = %{
      line_items: [
        %{
          # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
          price: System.get_env("PRODUCT_PRICE_ID"),
          quantity: 1
        }
      ],
      mode: "payment",
      # https://stripe.com/docs/payments/checkout/custom-success-page
      success_url:
        url <> ~p"/purchase/success?session_id={CHECKOUT_SESSION_ID}",
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
