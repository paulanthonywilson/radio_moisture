defmodule RadioMoistureFw.Mixfile do
  use Mix.Project

  @target System.get_env("NERVES_TARGET") || "rpi"

  def project do
    [app: :radio_moisture_fw,
     version: "0.0.1",
     target: @target,
     archives: [nerves_bootstrap: "~> 0.1.4"],
     deps_path: "../../deps/#{@target}",
     build_path: "../../_build/#{@target}",
     config_path: "../../config/config.exs",
     lockfile: "../../mix.lock",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(Mix.env),
     deps: deps ++ system(@target, Mix.env)]
  end

  def application do
    [mod: {RadioMoistureFw, []},
     applications: applications(Mix.env)]
  end

  def applications(:prod), do: [:nerves_interim_wifi | general_apps]
  def applications(_), do: general_apps

  defp general_apps, do: [:logger, :runtime_tools, :porcelain, :rm_slack]

  def deps do
    [
      {:nerves, "~> 0.3.0"},
      {:nerves_interim_wifi, "~> 0.1.0", only: :prod},
      {:porcelain, ">= 0.0.0"},
      {:dummy_nerves, in_umbrella: true, only: [:dev, :test]},
      {:rm_slack, in_umbrella: true},
    ]
  end

  def system(target, :prod) do
    [{:"nerves_system_#{target}", ">= 0.0.0"}]
  end
  def system(_, _), do: []

  def aliases(:prod) do
    ["deps.precompile": ["nerves.precompile", "deps.precompile"],
     "deps.loadpaths":  ["deps.loadpaths", "nerves.loadpaths"]]
  end
  def aliases(_), do: []
end
