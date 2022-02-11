defmodule BookStore.StoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BookStore.Store` context.
  """

  @doc """
  Generate a unique book isbn.
  """
  def unique_book_isbn, do: "some isbn#{System.unique_integer([:positive])}"

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        author_first_name: "some author_first_name",
        author_full_name: "some author_full_name",
        author_last_name: "some author_last_name",
        description: "some description",
        genre: "some genre",
        isbn: unique_book_isbn(),
        price: 120.5,
        title: "some title",
        year_published: 42
      })
      |> BookStore.Store.create_book()

    book
  end
end
