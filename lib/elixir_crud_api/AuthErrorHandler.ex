defmodule ElixirCrudApi.AuthErrorHandler do
  import Plug.Conn
  #import Phoenix.View

  def unauthenticated(conn, _opts) do
    conn
    |> put_status(:unauthorized)
    #|> render(ElixirCrudApi.ErrorView, "401.json")
    |> halt()
  end

  def unauthorized(conn, _opts) do
    conn
    |> put_status(:forbidden)
    #|> render(ElixirCrudApi.ErrorView, "403.json")
    |> halt()
  end

  def json_response(conn, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(data))
  end

  def auth_error(conn, {:invalid_token, _reason}, _opts) do
    conn
    |> put_status(:unauthorized)
    #|> json(%{"error" => "Invalid token"})
    |> json_response(%{"error" => "Invalid token"})
    #|> halt()
  end

  def auth_error(conn, _error, _opts) do
    conn
    |> put_status(:forbidden)
    |> json_response(%{"error" => "Access forbidden"})
    #|> halt()
  end
end
