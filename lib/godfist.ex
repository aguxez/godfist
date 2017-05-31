defmodule Godfist do
  @moduledoc """
  Godfist is a wrapper for the League of Legends ReST API written in Elixir.

  There are some endpoints that I'll be adding later which will be the static
  data from Data Dragon and Tournament support.

  Every function requires that you pass the region to execute the request to
  since Riot uses that to Rate limit the usage of the api. Every region should
  be passed as an Atom, remember that :P

  Set your api key in your `config.exs` file with the given params.

  ```elixir
  config :godfist,
  token: "YOUR API KEY",
  time: 1000, # This is the minimum default from Riot, set this time in miliseconds.
  amount: 10 # Amount of request limit, default minium is 10 each 10 seconds.
  ```
  """
end
