defmodule RmSerial.SerialRead do
	use GenServer

	@name __MODULE__

	def start_link(port, speed) do
		GenServer.start_link(__MODULE__, {port, speed}, name: @name)
	end


	def init({port, speed}) do
		{:ok, uart_pid} = Nerves.UART.start_link

		:ok = Nerves.UART.open(uart_pid,
													 port,
													 speed: speed,
													 active: true,
													 framing: {Nerves.UART.Framing.Line, separator: "\r\n"},)
		{:ok, []}
	end


	def handle_info({:nerves_uart, "ttyAMA0", message}, state) do
		RmSlack.Bot.send_message(message)
		{:noreply, state}
	end
end
