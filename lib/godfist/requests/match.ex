defmodule Godfist.Match do
  @moduledoc """
  Module to interact with the match endpoint.
  """

  alias Godfist.HTTP

  @v "v3"

  @doc """
  Get match information by match id.

  ## Example

  ```elixir
  iex> Godfist.Match.get_match(:oce, matchid)
  ```
  """
  def get_match(region, matchid) do
    # This function gets a specific information about a match.
    rest = "/lol/match/#{@v}/matches/#{matchid}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get matchlist for a ranked games played on given account id and region
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
  def matchlist(region, id, opts \\ []) do
    # This one retrieves a list of match from a given player with optional filters.
    #
    # Yes, I tried to get every single optional parameter from the options
    # Yes I know it looks ugly
    begin_time = Keyword.get(opts, :begin_time, "")
    queue = Keyword.get(opts, :queue, "")
    end_index = Keyword.get(opts, :end_index, "")
    season = Keyword.get(opts, :season, "")
    champion = Keyword.get(opts, :champion, "")
    begin_index = Keyword.get(opts, :begin_index, "")
    end_time = Keyword.get(opts, :end_time, "")

    # Yes, again, I know this not so appealing.
    rest =
      "/lol/match/#{@v}/matchlists/by-account/#{id}?beginTime=#{begin_time}&" <>
      "queue=#{queue}&endIndex=#{end_index}&season=#{season}&champion=#{champion}&" <>
      "beginIndex=#{begin_index}&endTime=#{end_time}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get the last 20 match of a given player.

  ## Example

  ```elixir
  iex> Godfist.Match.recent(:lan, summid)
  ```
  """
  def recent(region, id) do
    rest = "/lol/match/#{@v}/matchlists/by-account/#{id}/recent"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get match timeline by match id.

  ## Example

  ```elixir
  Godfist.Match.timeline(:na, matchid)
  ```
  """
  def timeline(region, id) do
    rest = "/lol/match/#{@v}/timelines/by-match/#{id}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get match ids by tournament code.

  ## Example

  ```elixir
  iex> Godfist.Match.tournament_by_code(:oce, tournament_id)
  ```
  """
  def tournament_by_code(region, tournament_id) do
    # Have in mind that if you don't have permissions to fetch this api
    # it will most likely return a 404. You can't use this one with a development
    # key, you must register your application.
    #
    # I didn't test these two endpoints because I don't have permissions but they
    # should work as intended, if anything, please let me know.
    rest = "/lol/match/#{@v}/matches/by-tournament-code/#{tournament_id}/ids"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get match by match id a tournament code.

  ## Example

  ```elixir
  iex> Godfist.Match.tournament_by_match(:euw, matchid, tournament_id)
  ```
  """
  def tournament_by_match(region, match_id, tournament_id) do
    rest = "/lol/match/#{@v}/matches/#{match_id}/by-tournament-code/#{tournament_id}"

    HTTP.get(region: region, rest: rest)
  end
end
