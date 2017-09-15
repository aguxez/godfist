defmodule Godfist.Masteries do
  @moduledoc """
  Module to interact with the masteries endpoint.
  """

  alias Godfist.LeagueRates

  @v "v3"

  @doc """
  Get masteries from a given summoner id.

  ## Example

  ```elixir
  iex> Godfist.Masteries.get(:lan, summid)
  ```
  """
  @spec get(atom, integer) :: {:ok, map} | {:error, String.t}
  def get(region, sumid) do
    rest = "/lol/platform/#{@v}/masteries/by-summoner/#{sumid}"

    LeagueRates.handle_rate(region, rest, :champion_masteries_runes)
  end
end
