# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

import_config "secret.exs"
config :porcelain, driver: Porcelain.Driver.Basic

config :radio_moisture_fw, :ping_mate, :"bob@10.0.0.13"

config :logger, level: :info
