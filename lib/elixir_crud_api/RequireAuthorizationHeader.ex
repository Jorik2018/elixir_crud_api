defmodule ElixirCrudApi.RequireAuthorizationHeader do
  import Plug.Conn

  def init(_opts), do: %{}

  def call(conn, _opts) do
    IO.inspect("ElixirCrudApi.RequireAuthorizationHeader plug called")
    case get_req_header(conn, "authorization") do
      [token] when is_binary(token) ->
        conn
      _ ->
        conn
        |> put_status(:unauthorized)
        |> json_response(%{"error" => "Authorization header is missing or invalid"})
        |> halt()
    end
  end

  defp json_response(conn, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, Jason.encode!(data))
  end
end
