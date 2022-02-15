defmodule BookStoreWeb.BookControllerTest do
  use BookStoreWeb.ConnCase

  import BookStore.StoreFixtures

  alias BookStore.Store.Book

  @create_attrs %{
    author_first_name: "some author_first_name",
    author_full_name: "some author_full_name",
    author_last_name: "some author_last_name",
    description: "some description",
    genre: "some genre",
    isbn: "some isbn",
    price: 120.5,
    title: "some title",
    year_published: 42
  }
  @update_attrs %{
    author_first_name: "some updated author_first_name",
    author_full_name: "some updated author_full_name",
    author_last_name: "some updated author_last_name",
    description: "some updated description",
    genre: "some updated genre",
    isbn: "some updated isbn",
    price: 456.7,
    title: "some updated title",
    year_published: 43
  }
  @invalid_attrs %{author_first_name: nil, author_full_name: nil, author_last_name: nil, description: nil, genre: nil, isbn: nil, price: nil, title: nil, year_published: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all books", %{conn: conn} do
      conn = get(conn, Routes.book_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create book" do
    test "renders book when data is valid", %{conn: conn} do
      conn = post(conn, Routes.book_path(conn, :create), book: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.book_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "author_first_name" => "some author_first_name",
               "author_full_name" => "some author_full_name",
               "author_last_name" => "some author_last_name",
               "description" => "some description",
               "genre" => "some genre",
               "isbn" => "some isbn",
               "price" => 120.5,
               "title" => "some title",
               "year_published" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.book_path(conn, :create), book: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update book" do
    setup [:create_book]

    test "renders book when data is valid", %{conn: conn, book: %Book{id: id} = book} do
      conn = put(conn, Routes.book_path(conn, :update, book), book: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.book_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "author_first_name" => "some updated author_first_name",
               "author_full_name" => "some updated author_full_name",
               "author_last_name" => "some updated author_last_name",
               "description" => "some updated description",
               "genre" => "some updated genre",
               "isbn" => "some updated isbn",
               "price" => 456.7,
               "title" => "some updated title",
               "year_published" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, book: book} do
      conn = put(conn, Routes.book_path(conn, :update, book), book: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete book" do
    setup [:create_book]

    test "deletes chosen book", %{conn: conn, book: book} do
      conn = delete(conn, Routes.book_path(conn, :delete, book))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.book_path(conn, :show, book))
      end
    end
  end

  defp create_book(_) do
    book = book_fixture()
    %{book: book}
  end
end
