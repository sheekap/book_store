defmodule BookStore.Store.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :author_first_name, :string
    field :author_full_name, :string
    field :author_last_name, :string
    field :description, :string
    field :genre, :string
    field :isbn, :string
    field :price, :float
    field :title, :string
    field :year_published, :integer

    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :isbn, :description, :price, :author_first_name, :author_last_name, :author_full_name, :genre, :year_published])
    |> validate_required([:title, :isbn, :description, :price, :author_first_name, :author_last_name, :genre, :year_published])
    |> generate_full_name()
    |> unique_constraint(:isbn)
  end

  defp generate_full_name(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{author_first_name: first_name, author_last_name: last_name}} ->
        put_change(changeset, :author_full_name, "#{first_name} #{last_name}")
      _ -> changeset
    end
  end
end
