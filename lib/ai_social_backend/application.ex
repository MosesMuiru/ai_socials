defmodule AiSocialBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AiSocialBackendWeb.Telemetry,
      #   AiSocialBackend.Repo,
      {DNSCluster, query: Application.get_env(:ai_social_backend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AiSocialBackend.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AiSocialBackend.Finch},
      # Start a worker by calling: AiSocialBackend.Worker.start_link(arg)
      # {AiSocialBackend.Worker, arg},
      # Start to serve requests, typically the last entry
      AiSocialBackendWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AiSocialBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AiSocialBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
