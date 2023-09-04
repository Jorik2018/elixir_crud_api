defmodule ElixirCrudApiWeb.PeopleJSON do
  alias ElixirCrudApi.Directory.People

  @doc """
  Renders a list of people.
  """
  def index(%{people: people}) do
    %{data: for(people <- people, do: data(people))}
  end

  @doc """
  Renders a single people.
  """
  def show(%{people: people}) do
    %{data: data(people)}
  end

  @doc """
  Renders an error response for a person not found.
  """
  def person_not_found(_) do
    %{error: "Person not found"}
  end

  defp data(%People{} = people) do
    %{
      id: people.id,
      firstName: people.firstName,
      lastName: people.lastName,
      age: people.age
    }
  end
end
