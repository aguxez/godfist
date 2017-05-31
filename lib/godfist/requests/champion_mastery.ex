defmodule Godfist.ChampionMastery do
  @moduledoc """
  Module to get Champion masteries
  """

  alias Godfist.HTTP

  @endpoint "/lol/champion-mastery/v3"

  @doc """
  Get all champion mastery entries by number of champion points.

  ## Example

  ```elixir
  iex> Godfist.ChampionMastery.by_summoner(:na, summonerid)
  ```
  """
  def by_summoner(region, id) do
    rest = @endpoint <> "/champion-masteries/by-summoner/#{id}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a champion mastery by player id and champion id.

  ## Example

  ```elixir
  iex> Godfist.ChampionMastery.by_champion(:na, summid, champid)
  ```
  """
  def by_champion(region, id, champ_id) do
    rest = @endpoint <> "/champion-masteries/by-summoner/#{id}/by-champion/#{champ_id}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a player's total mastery score by player id.

  ## Example

  ```elixir
  iex> Godfist.ChampionMastery.total(:lan, summid)
  ```
  """
  def total(region, id) do
    rest = @endpoint <> "/scores/by-summoner/#{id}"

    HTTP.get(region: region, rest: rest)
  end
end
