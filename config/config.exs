use Mix.Config

# Key :rates works as :env in this case.
config :godfist,
  rates: :dev,
  godfist_api: Godfist.HTTP

import_config "#{Mix.env()}.exs"
