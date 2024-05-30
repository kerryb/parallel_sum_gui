defmodule ParallelSumGuiWeb.HomeLive do
  @moduledoc false
  use ParallelSumGuiWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, total: 0)}
  end
end
