defmodule RmSlack do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Restarter, [{RmSlack.BotSupervisor, :start_link, []}, 30_000, [name: :bot_restarter]])
    ]

    opts = [strategy: :one_for_one, name: RmSlack.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
