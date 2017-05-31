defmodule Godfist.League do
  @moduledoc """
  Module to interact with the League endpoint.
  """

  alias Godfist.HTTP

  @v "v2.5"

  @queues %{
    flex_sr: "RANKED_FLEX_SR",
    flex_tt: "RANKED_FLEX_TT",
    solo_5: "RANKED_SOLO_5x5",
    team_3: "RANKED_TEAM_3x3",
    team_5: "RANKED_TEAM_5x5"
  }

  @doc """
  Get a list of the players from a league of the given list of summoner ids.

  ## Example

  ```elixir
  iex> Godfist.League.get_all(:lan, 123)

  iex> Godfist.League.get_all(:lan, [123, 456, 789])
  ```
  """
  def get_all(region, sumid) when is_list(sumid) do
    ids = Enum.join(sumid, ",")
    server = Atom.to_string(region)

    rest = "/api/lol/#{server}/#{@v}/league/by-summoner/#{ids}"

    HTTP.get(region: region, rest: rest)
  end
  def get_all(region, sumid) do
    server = Atom.to_string(region)

    rest = "/api/lol/#{server}/#{@v}/league/by-summoner/#{sumid}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get league entries mapped by Summoner Id from a given list of ids.

  ## Example

  ```elixir
  iex> Godfist.League.get_entry(:lan, 123)

  iex> Godfist.League.get_entry(:lan, [123, 456, 789])
  ```
  """
  def get_entry(region, sumid) when is_list(sumid) do
    ids = Enum.join(sumid, ",")
    server = Atom.to_string(region)

    rest = "/api/lol/#{server}/#{@v}/league/by-summoner/#{ids}/entry"

    HTTP.get(region: region, rest: rest)
  end
  def get_entry(region, sumid) do
    server = Atom.to_string(region)

    rest = "/api/lol/#{server}/#{@v}/league/by-summoner/#{sumid}/entry"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get challenger tier League mapped to queues.

  Queues are: `flex_sr, flex_tt, solo_5, team_5, team_3`

  ## Example

  ```elixir
  iex> Godfist.League.challenger(:na, :solo_5)

  iex> Godfist.League.challenger(:oce, :team_3)
  ```
  """
  def challenger(region, rank_queue) do
    queue = Map.get(@queues, rank_queue)
    server = Atom.to_string(region)

    rest = "/api/lol/#{server}/#{@v}/league/challenger?type=#{queue}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get master tier League mapped to queues.

  See `challenger/2` to a list of queues.

  ## Example

  ```elixir
  iex> Godfist.League.master(:eune, :flex_sr)
  ```
  """
  def master(region, rank_queue) do
    queue = Map.get(@queues, rank_queue)
    server = Atom.to_string(region)

    rest = "/api/lol/#{server}/#{@v}/league/master?type=#{queue}"

    HTTP.get(region: region, rest: rest)
  end
end
