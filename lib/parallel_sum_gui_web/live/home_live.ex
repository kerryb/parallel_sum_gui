defmodule ParallelSumGuiWeb.HomeLive do
  @moduledoc false
  use ParallelSumGuiWeb, :live_view

  alias ParallelSum.Counter
  alias ParallelSum.DummyService
  alias ParallelSum.Runner
  alias ParallelSum.Total
  alias Phoenix.LiveView

  @impl LiveView
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(form: to_form(%{"tasks" => 100}))
     |> assign_total()}
  end

  @impl LiveView
  def handle_event("reset", _unsigned_params, socket) do
    Counter.reset()
    Total.reset()
    {:noreply, assign_total(socket)}
  end

  def handle_event("submit", %{"tasks" => tasks}, socket) do
    view_pid = self()
    Task.start(fn -> call_runner(String.to_integer(tasks), view_pid) end)
    {:noreply, socket}
  end

  @impl LiveView
  def handle_info(:total_updated, socket), do: {:noreply, assign_total(socket)}

  defp assign_total(socket), do: assign(socket, total: Total.value())

  defp call_runner(tasks, view_pid) do
    Runner.run(fn -> run_and_notify(view_pid) end, tasks)
  end

  def run_and_notify(view_pid) do
    total = DummyService.run()
    send(view_pid, :total_updated)
    total
  end
end
