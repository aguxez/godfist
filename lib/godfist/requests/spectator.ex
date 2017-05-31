defmodule Godfist.Spectator do
  @moduledoc """
  Module to interact with the Spectator endpoint.
  """

  alias Godfist.HTTP

  @endpoint "/lol/spectator/v3"

  @doc """
  Get current game of given summoner.

  ## Example

  ```elixir
  iex> Godfist.Spectator.active_game(:ru, summid)
  ```
  """
  def active_game(region, sumid) do
    rest = @endpoint <> "/active-games/by-summoner/#{sumid}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get current featured games of a region.

  ## Example

  ```elixir
  iex> Godfist.Spectator.featured_games(:jp)
  ```
  """
  def featured_games(region) do
    rest = @endpoint <> "/featured-games"

    HTTP.get(region: region, rest: rest)
  end
end
