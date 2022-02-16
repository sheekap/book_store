defmodule BookStoreWeb.AdminLive do
  use BookStoreWeb, :live_view

  alias BookStore.Store

  def mount(_params, _session, socket) do
    socket = assign_counts(socket)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1>Admin Stuff</h1>
      <div>
        <p>Total Number of Books</p>
        <span><%= @num_books %></span>
      </div>
      <div>
        <p>Total Number of Authors</p>
        <span><%= @num_authors %></span>
      </div>
    </div>
    <div>
    <button phx-click="refresh">Refresh</button>
    </div>
    """
  end

  def handle_event("refresh", _, socket) do
    socket = assign_counts(socket)
    {:noreply, socket}
  end

  defp assign_counts(socket) do
    assign(socket,
    num_books: Enum.count(Store.list_books),
    num_authors: Enum.count(Store.list_authors)
    )
  end
end
