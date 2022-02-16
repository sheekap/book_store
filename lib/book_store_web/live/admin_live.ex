defmodule BookStoreWeb.AdminLive do
  use BookStoreWeb, :live_view

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        avg_price_per_genre: 10.00,
        num_books: 200,
        num_authors: 12,
        avg_books_per_author: 2
      )
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Admin</h1>
    <%= @num_books %>
    """
  end
end
