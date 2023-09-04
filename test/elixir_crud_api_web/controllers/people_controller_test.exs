defmodule ElixirCrudApiWeb.PeopleControllerTest do
  use ElixirCrudApiWeb.ConnCase

  import ElixirCrudApi.DirectoryFixtures

  alias ElixirCrudApi.Directory.People

  @create_attrs %{
    first_name: "some first_name",
    last_name: "some last_name",
    age: 42
  }
  @update_attrs %{
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    age: 43
  }
  @invalid_attrs %{first_name: nil, last_name: nil, age: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all people", %{conn: conn} do
      conn = get(conn, ~p"/api/people")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create people" do
    test "renders people when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/people", people: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/people/#{id}")

      assert %{
               "id" => ^id,
               "age" => 42,
               "first_name" => "some first_name",
               "last_name" => "some last_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/people", people: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update people" do
    setup [:create_people]

    test "renders people when data is valid", %{conn: conn, people: %People{id: id} = people} do
      conn = put(conn, ~p"/api/people/#{people}", people: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/people/#{id}")

      assert %{
               "id" => ^id,
               "age" => 43,
               "first_name" => "some updated first_name",
               "last_name" => "some updated last_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, people: people} do
      conn = put(conn, ~p"/api/people/#{people}", people: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete people" do
    setup [:create_people]

    test "deletes chosen people", %{conn: conn, people: people} do
      conn = delete(conn, ~p"/api/people/#{people}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/people/#{people}")
      end
    end
  end

  defp create_people(_) do
    people = people_fixture()
    %{people: people}
  end
end
