defmodule RmSlack.Mixfile do
  use Mix.Project

  def project do
    [app: :rm_slack,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger, :slacker, :restarter, :websocket_client],
     mod: {RmSlack, []}]
  end

  defp deps do
    [
      {:slacker, ">= 0.0.0"},
      {:restarter, ">= 0.0.0"},
      {:websocket_client, github: "jeremyong/websocket_client"},
    ]
  end
end
