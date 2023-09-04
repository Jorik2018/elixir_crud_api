defmodule ElixirCrudApi.Directory.People do
  use Ecto.Schema
  import Ecto.Changeset

  schema "people" do
    field :firstName, :string, source: :first_name  # Map the fields to camelCase
    field :lastName, :string, source: :last_name
    field :age, :integer

    timestamps()
  end

  @doc false
  def changeset(people, attrs) do
    excluded_fields = [:id, :inserted_at, :updated_at]

    fields = Enum.reduce(__schema__(:fields), %{}, fn field, acc ->
      Map.put(acc, field, nil)
    end)

    # Exclude specified fields from the list of fields
    filtered_fields = Enum.reject(Map.keys(fields), fn field ->
      field in excluded_fields
    end)

    people
    |> cast(attrs, filtered_fields)
    |> validate_required(filtered_fields)
  end
end
