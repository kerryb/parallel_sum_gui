defmodule ParallelSumGui.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ParallelSumGuiWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:parallel_sum_gui, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ParallelSumGui.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ParallelSumGui.Finch},
      # Start a worker by calling: ParallelSumGui.Worker.start_link(arg)
      # {ParallelSumGui.Worker, arg},
      # Start to serve requests, typically the last entry
      ParallelSumGuiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ParallelSumGui.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ParallelSumGuiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
