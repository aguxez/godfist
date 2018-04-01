defmodule Godfist.ChampionMastery do
  @moduledoc """
  Module to get Champion masteries
  """

  alias Godfist.LeagueRates

  @endpoint "/lol/champion-mastery/v3"

  @doc """
  Get all champion mastery entries by number of champion points.

  ## Example

  ```elixir
  iex> Godfist.ChampionMastery.by_summoner(:na, summonerid)
  ```
  """
  @spec by_summoner(atom, integer) :: {:ok, map} | {:error, String.t()}
  def by_summoner(region, id) do
    rest = @endpoint <> "/champion-masteries/by-summoner/#{id}"

    LeagueRates.handle_rate(region, rest, :other)
  end

  @doc """
  Get a champion mastery by player id and champion id.

  ## Example

  ```elixir
  iex> Godfist.ChampionMastery.by_champion(:na, summid, champid)
  ```
  """
  @spec by_champion(atom, integer, integer) :: {:ok, map} | {:error, String.t()}
  def by_champion(region, id, champ_id) do
    rest = @endpoint <> "/champion-masteries/by-summoner/#{id}/by-champion/#{champ_id}"

    LeagueRates.handle_rate(region, rest, :other)
  end

  @doc """
  Get a player's total mastery score by player id.

  ## Example

  ```elixir
  iex> Godfist.ChampionMastery.total(:lan, summid)
  ```
  """
  @spec total(atom, integer) :: {:ok, map} | {:error, String.t()}
  def total(region, id) do
    rest = @endpoint <> "/scores/by-summoner/#{id}"

    LeagueRates.handle_rate(region, rest, :other)
  end
end
