defmodule RmSerial.Mixfile do
  use Mix.Project

  def project do
    [app: :rm_serial,
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
    [applications: [:logger, :nerves_uart],
     mod: {RmSerial, []}]
  end

  defp deps do
    [
      {:nerves_uart, "~> 0.1.1"}
    ]
  end
end
