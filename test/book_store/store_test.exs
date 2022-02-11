defmodule BookStore.StoreTest do
  use BookStore.DataCase

  alias BookStore.Store

  describe "books" do
    alias BookStore.Store.Book

    import BookStore.StoreFixtures

    @invalid_attrs %{author_first_name: nil, author_full_name: nil, author_last_name: nil, description: nil, genre: nil, isbn: nil, price: nil, title: nil, year_published: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Store.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Store.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{author_first_name: "some author_first_name", author_full_name: "some author_full_name", author_last_name: "some author_last_name", description: "some description", genre: "some genre", isbn: "some isbn", price: 120.5, title: "some title", year_published: 42}

      assert {:ok, %Book{} = book} = Store.create_book(valid_attrs)
      assert book.author_first_name == "some author_first_name"
      assert book.author_full_name == "some author_full_name"
      assert book.author_last_name == "some author_last_name"
      assert book.description == "some description"
      assert book.genre == "some genre"
      assert book.isbn == "some isbn"
      assert book.price == 120.5
      assert book.title == "some title"
      assert book.year_published == 42
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Store.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{author_first_name: "some updated author_first_name", author_full_name: "some updated author_full_name", author_last_name: "some updated author_last_name", description: "some updated description", genre: "some updated genre", isbn: "some updated isbn", price: 456.7, title: "some updated title", year_published: 43}

      assert {:ok, %Book{} = book} = Store.update_book(book, update_attrs)
      assert book.author_first_name == "some updated author_first_name"
      assert book.author_full_name == "some updated author_full_name"
      assert book.author_last_name == "some updated author_last_name"
      assert book.description == "some updated description"
      assert book.genre == "some updated genre"
      assert book.isbn == "some updated isbn"
      assert book.price == 456.7
      assert book.title == "some updated title"
      assert book.year_published == 43
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Store.update_book(book, @invalid_attrs)
      assert book == Store.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Store.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Store.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Store.change_book(book)
    end
  end
end
