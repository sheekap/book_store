defmodule BookStore.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :isbn, :text
      add :description, :text
      add :price, :float
      add :author_first_name, :string
      add :author_last_name, :string
      add :author_full_name, :string
      add :genre, :string
      add :year_published, :integer

      timestamps()
    end

    create unique_index(:books, [:isbn])
  end
end
