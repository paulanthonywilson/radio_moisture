defmodule RmSerial do
  use Application

  @serial_port Application.fetch_env!(:rm_serial, :port)
  @serial_speed Application.fetch_env!(:rm_serial, :speed)

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(RmSerial.SerialRead, [@serial_port, @serial_speed])
    ]

    opts = [strategy: :one_for_one, name: RmSerial.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
