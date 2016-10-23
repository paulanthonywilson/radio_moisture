defmodule RadioMoistureFw do
  use Application

  @wifi_opts Application.get_env(:radio_moisture_fw, :wifi_opts)

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Nerves.InterimWiFi, ["wlan0", @wifi_opts], function: :setup),
      worker(RadioMoistureFw.DistributeNode, []),
      worker(RadioMoistureFw.Ntp, []),
    ]

    opts = [strategy: :one_for_one, name: RadioMoistureFw.Supervisor]
    Supervisor.start_link(children, opts)
  end

end
