# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

if Mix.env() == :prod do
  config :godfist,
    rates: :prod,
    godfist_api: Godfist.HTTP
else
  config :godfist, rates: :dev
end

import_config "#{Mix.env()}.exs"
