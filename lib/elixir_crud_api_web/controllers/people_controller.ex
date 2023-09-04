defmodule ElixirCrudApiWeb.PeopleController do
  use ElixirCrudApiWeb, :controller

  #alias ElixirCrudApi.Directory
  #alias ElixirCrudApi.Directory.People
  alias ElixirCrudApi.{Directory, Directory.People}


  plug Guardian.Plug.VerifyHeader when action in [:index, :create, :update, :delete]

  action_fallback ElixirCrudApiWeb.FallbackController

  def index(conn, _params) do
    people = Directory.list_people()
    render(conn, :index, people: people)
  end

  def create(conn, people_params) do
    with {:ok, %People{} = people} <- Directory.create_people(people_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/people/#{people}")
      |> render(:show, people: people)
    end
  end

  def show(conn, %{"id" => id}) do
    people = Directory.get_people!(id)
    render(conn, :show, people: people)
  end

  def update(conn, %{"id" => id} = people_params) do # %{"id" => id, "people" => people_params}) do
    try do
      case Directory.get_people!(id) do
        {:ok, people} ->
          with {:ok, %People{} = updated_people} <- Directory.update_people(people, people_params) do
            render(conn, :show, people: updated_people)
          end
      end
    rescue
      _ -> render(conn, "person_not_found.json", status: 500)
    end
  end

  def delete(conn, %{"id" => id}) do
    people = Directory.get_people!(id)

    with {:ok, %People{}} <- Directory.delete_people(people) do
      send_resp(conn, :no_content, "")
    end
  end
end
