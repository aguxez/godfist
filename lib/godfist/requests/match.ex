defmodule Godfist.Match do
  @moduledoc """
  Module to interact with the match endpoint.
  """

  alias Godfist.LeagueRates

  @v "v3"

  @doc """
  Get match information by match id.

  ## Example

  ```elixir
  iex> Godfist.Match.get_match(:oce, matchid)
  ```
  """
  @spec get_match(atom, integer) :: {:ok, map} | {:error, String.t()}
  def get_match(region, matchid) do
    # This function gets a specific information about a match.
    rest = "/lol/match/#{@v}/matches/#{matchid}"

    LeagueRates.handle_rate(region, rest, :match)
  end

  @doc """
  Get matchlist for a ranked game played for an account id and region
  filtering with a given set of options.

  Options are:
  * `:begin_time`, The begin time to use for filtering matchlist specified as
  epoch miliseconds.
  * `:queue`, Set of given queue IDs for which to filtering matchlist.
  * `end_index`, The end index to use for filtering matchlist.
  * `:season`, Set of season IDs for which to filtering matchlist.
  * `:champion`, Id of champion to filter matchlist.
  * `:begin_index`, The begin index to use for filtering matchlist.
  * `:end_time`, The end time to use for filtering matchlist specified by
  epoch miliseconds.

  ## Example

  ```elixir
  iex> Godfist.Match.matchlist(:lan, summid, [champion: 64, queue: 420])
  ```
  """
  @spec matchlist(atom, integer, Keyword.t()) :: {:ok, map} | {:error, String.t()}
  def matchlist(region, id, opts \\ []) do
    # This one retrieves a list of match from a given player with optional
    # filters.
    opt = Keyword.merge([], opts)

    # Yes, I know this not so appealing.
    rest =
      "/lol/match/#{@v}/matchlists/by-account/#{id}?beginTime=#{opt[:begin_time]}&" <>
        "queue=#{opt[:queue]}&endIndex=#{opt[:end_index]}&season=#{opt[:season]}&" <>
        "champion=#{opt[:champion]}&beginIndex=#{opt[:begin_index]}&endTime=#{opt[:end_time]}"

    LeagueRates.handle_rate(region, rest, :matchlist)
  end

  @doc """
  Get match timeline by match id.

  ## Example

  ```elixir
  Godfist.Match.timeline(:na, matchid)
  ```
  """
  @spec timeline(atom, integer) :: {:ok, map} | {:error, String.t()}
  def timeline(region, id) do
    rest = "/lol/match/#{@v}/timelines/by-match/#{id}"

    LeagueRates.handle_rate(region, rest, :match)
  end

  @doc """
  Get match ids by tournament code.

  ## Example

  ```elixir
  iex> Godfist.Match.tournament_by_code(:oce, tournament_id)
  ```
  """
  @spec tournament_by_code(atom, integer) :: {:ok, map} | {:error, String.t()}
  def tournament_by_code(region, tournament_id) do
    # Have in mind that if you don't have permissions to fetch this api
    # it will most likely return a 404. You can't use this one with a
    # development key, you must register your application.
    #
    # I didn't test these two endpoints because I don't have permissions but
    # they
    # should work as intended, if anything, please let me know.
    rest = "/lol/match/#{@v}/matches/by-tournament-code/#{tournament_id}/ids"

    LeagueRates.handle_rate(region, rest, :other)
  end

  @doc """
  Get match by match id a tournament code.

  ## Example

  ```elixir
  iex> Godfist.Match.tournament_by_match(:euw, matchid, tournament_id)
  ```
  """
  @spec tournament_by_match(atom, integer, integer) :: {:ok, map} | {:error, String.t()}
  def tournament_by_match(region, match_id, tournament_id) do
    rest = "/lol/match/#{@v}/matches/#{match_id}/by-tournament-code/#{tournament_id}"

    LeagueRates.handle_rate(region, rest, :other)
  end
end
