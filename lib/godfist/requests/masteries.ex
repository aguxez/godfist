defmodule Godfist.Masteries do
  @moduledoc """
  Module to interact with the masteries endpoint.
  """

  alias Godfist.HTTP

  @v "v3"

  @doc """
  Get masteries from a given summoner id.

  ## Example

  ```elixir
  iex> Godfist.Masteries.get(:lan, summid)
  ```
  """
  def get(region, sumid) do
    rest = "/lol/platform/#{@v}/masteries/by-summoner/#{sumid}"

    HTTP.get(region: region, rest: rest)
  end
end
