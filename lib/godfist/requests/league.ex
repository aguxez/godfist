defmodule Godfist.League do
  @moduledoc """
  Module to interact with the League endpoint.
  """

  alias Godfist.LeagueRates

  @v "v3"

  @queues %{
    flex_sr: "RANKED_FLEX_SR",
    flex_tt: "RANKED_FLEX_TT",
    solo_5: "RANKED_SOLO_5x5"
  }

  @doc """
  Get a list of the players from a league of the given Summoner id.

  ## Example

  ```elixir
  iex> Godfist.League.get_all(:lan, 123)
  ```
  """
  @spec get_all(atom, integer) :: {:ok, map} | {:error, String.t}
  def get_all(region, sumid) do
    rest = "/lol/league/#{@v}/leagues/by-summoner/#{sumid}"

    LeagueRates.handle_rate(region, rest)
  end

  @doc false
  def get_entry(region, sumid) do
    IO.warn("Godfist.League.get_entry/2 is deprecated, use Godfist.League.positions/2 instead",
      Macro.Env.stacktrace(__ENV__))

    positions(region, sumid)
  end

  @doc """
  Get League positions in all queues for a given Summoner ID.

  ## Example

  ```elixir
  iex> Godfist.League.positions(:lan, 24244)
  ```
  """
  @spec positions(atom, integer) :: {:ok, map} | {:error, String.t}
  def positions(region, sumid) do
    rest = "/lol/league/#{@v}/positions/by-summoner/#{sumid}"

    LeagueRates.handle_rate(region, rest)
  end

  @doc """
  Get challenger tier League mapped to queues.

  Queues are: `flex_sr, flex_tt, solo_5`

  ## Example

  ```elixir
  iex> Godfist.League.challenger(:na, :solo_5)

  iex> Godfist.League.challenger(:oce, :team_3)
  ```
  """
  @spec challenger(atom, atom) :: {:ok, map} | {:error, String.t}
  def challenger(region, rank_queue) do
    queue = Map.get(@queues, rank_queue)

    rest = "/lol/league/#{@v}/challengerleagues/by-queue/#{queue}"

    LeagueRates.handle_rate(region, rest)
  end

  @doc """
  Get master tier League mapped to queues.

  See `challenger/2` for a list of queues.

  ## Example

  ```elixir
  iex> Godfist.League.master(:eune, :flex_sr)
  ```
  """
  @spec master(atom, atom) :: {:ok, map} | {:error, String.t}
  def master(region, rank_queue) do
    queue = Map.get(@queues, rank_queue)

    rest = "/lol/league/#{@v}/masterleagues/by-queue/#{queue}"

    LeagueRates.handle_rate(region, rest)
  end
end
