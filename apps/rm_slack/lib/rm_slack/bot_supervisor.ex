defmodule RmSlack.BotSupervisor do
  use Supervisor

  @moduledoc false
  @slack_token Application.get_env(:rm_slack, :slack_token)
  @name __MODULE__

  def start_link do
    Supervisor.start_link(__MODULE__, {}, name: @name)
  end

  def init(_) do
    children = [
      worker(RmSlack.Bot, [@slack_token, [name: RmSlack.Bot]])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
