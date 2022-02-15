defmodule BookStoreWeb.BookView do
  use BookStoreWeb, :view
  alias BookStoreWeb.BookView

  def render("index.json", %{books: books}) do
    %{data: render_many(books, BookView, "book.json")}
  end

  def render("show.json", %{book: book}) do
    %{data: render_one(book, BookView, "book.json")}
  end

  def render("book.json", %{book: book}) do
    %{
      id: book.id,
      title: book.title,
      isbn: book.isbn,
      description: book.description,
      price: book.price,
      author_first_name: book.author_first_name,
      author_last_name: book.author_last_name,
      author_full_name: book.author_full_name,
      genre: book.genre,
      year_published: book.year_published
    }
  end
end
