defmodule ParallelSumGuiWeb.HomeLive do
  @moduledoc false
  use ParallelSumGuiWeb, :live_view

  alias ParallelSum.Total
  alias Phoenix.LiveView

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok, assign(socket, total: Total.value())}
  end

  @impl LiveView
  def handle_event("reset", _unsigned_params, socket) do
    Total.reset()
    {:noreply, assign(socket, total: Total.value())}
  end
end
