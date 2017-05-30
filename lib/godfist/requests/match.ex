defmodule Godfist.Match do
  @moduledoc false

  alias Godfist.HTTP

  @v "v3"

  # This one gets a specific information about a match.
  def get_match(region, matchid) do
    rest = "/lol/match/#{@v}/matches/#{matchid}"

    HTTP.get(region: region, rest: rest)
  end

  # This one retrieves a list of match from a given player with optional filters.
  def matchlist(region, id, opts \\ []) do
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

  def recent(region, id) do
    rest = "/lol/match/#{@v}/matchlists/by-account/#{id}/recent"

    HTTP.get(region: region, rest: rest)
  end

  def timeline(region, id) do
    rest = "/lol/match/#{@v}/timelines/by-match/#{id}"

    HTTP.get(region: region, rest: rest)
  end

  # Have in mind that if you don't have permissions to fetch this api
  # it will most likely return a 404. You can't use this one with a development
  # key, you must register your application.
  #
  # I didn't test these two endpoints because I don't have permissions but they
  # should work as intended, if anything, please let me know.
  def tournament_by_code(region, tournament_id) do
    rest = "/lol/match/#{@v}/matches/by-tournament-code/#{tournament_id}/ids"

    HTTP.get(region: region, rest: rest)
  end

  def tournament_by_match(region, match_id, tournament_id) do
    rest = "/lol/match/#{@v}/matches/#{match_id}/by-tournament-code/#{tournament_id}"

    HTTP.get(region: region, rest: rest)
  end
end
