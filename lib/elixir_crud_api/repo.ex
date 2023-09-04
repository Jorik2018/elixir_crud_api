defmodule ElixirCrudApi.Repo do
  use Ecto.Repo,
    otp_app: :elixir_crud_api,
    adapter: Ecto.Adapters.Postgres
end
