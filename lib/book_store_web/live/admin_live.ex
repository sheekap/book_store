defmodule BookStoreWeb.AdminLive do
  use BookStoreWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :book_count, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Admin</h1>
    <%= @book_count %>
    """
  end
end
