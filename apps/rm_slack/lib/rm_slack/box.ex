defmodule RmSlack.Bot do
  use Slacker
  use Slacker.Matcher

  @channel Application.get_env(:rm_slack, :channel)
  @name __MODULE__
  match ~r/hi/, :hi

  def hi(_, msg) do
    say self, msg["channel"], "Hello"
  end

  def send_message(message) do
    GenServer.cast(@name, {:send_message, message})
  end

  def handle_cast({:send_message, message}, state) do
    say self, @channel, message
    {:noreply, state}
  end
end
