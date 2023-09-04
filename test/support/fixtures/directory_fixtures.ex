defmodule ElixirCrudApi.DirectoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ElixirCrudApi.Directory` context.
  """

  @doc """
  Generate a people.
  """
  def people_fixture(attrs \\ %{}) do
    {:ok, people} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        last_name: "some last_name",
        age: 42
      })
      |> ElixirCrudApi.Directory.create_people()

    people
  end
end
