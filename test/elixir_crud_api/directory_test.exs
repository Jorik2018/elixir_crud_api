defmodule ElixirCrudApi.DirectoryTest do
  use ElixirCrudApi.DataCase

  alias ElixirCrudApi.Directory

  describe "people" do
    alias ElixirCrudApi.Directory.People

    import ElixirCrudApi.DirectoryFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, age: nil}

    test "list_people/0 returns all people" do
      people = people_fixture()
      assert Directory.list_people() == [people]
    end

    test "get_people!/1 returns the people with given id" do
      people = people_fixture()
      assert Directory.get_people!(people.id) == people
    end

    test "create_people/1 with valid data creates a people" do
      valid_attrs = %{first_name: "some first_name", last_name: "some last_name", age: 42}

      assert {:ok, %People{} = people} = Directory.create_people(valid_attrs)
      assert people.first_name == "some first_name"
      assert people.last_name == "some last_name"
      assert people.age == 42
    end

    test "create_people/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Directory.create_people(@invalid_attrs)
    end

    test "update_people/2 with valid data updates the people" do
      people = people_fixture()
      update_attrs = %{first_name: "some updated first_name", last_name: "some updated last_name", age: 43}

      assert {:ok, %People{} = people} = Directory.update_people(people, update_attrs)
      assert people.first_name == "some updated first_name"
      assert people.last_name == "some updated last_name"
      assert people.age == 43
    end

    test "update_people/2 with invalid data returns error changeset" do
      people = people_fixture()
      assert {:error, %Ecto.Changeset{}} = Directory.update_people(people, @invalid_attrs)
      assert people == Directory.get_people!(people.id)
    end

    test "delete_people/1 deletes the people" do
      people = people_fixture()
      assert {:ok, %People{}} = Directory.delete_people(people)
      assert_raise Ecto.NoResultsError, fn -> Directory.get_people!(people.id) end
    end

    test "change_people/1 returns a people changeset" do
      people = people_fixture()
      assert %Ecto.Changeset{} = Directory.change_people(people)
    end
  end
end
