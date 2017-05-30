defmodule Godfist.League do
  @moduledoc false

  alias Godfist.HTTP

  @v "v2.5"

  @queues %{
    flex_sr: "RANKED_FLEX_SR",
    flex_tt: "RANKED_FLEX_TT",
    solo_5: "RANKED_SOLO_5x5",
    team_3: "RANKED_TEAM_3x3",
    team_5: "RANKED_TEAM_5x5"
  }

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

  def challenger(region, rank_queue) do
    queue = Map.get(@queues, rank_queue)
    server = Atom.to_string(region)

    rest = "/api/lol/#{server}/#{@v}/league/challenger?type=#{queue}"

    HTTP.get(region: region, rest: rest)
  end

  def master(region, rank_queue) do
    queue = Map.get(@queues, rank_queue)
    server = Atom.to_string(region)

    rest = "/api/lol/#{server}/#{@v}/league/master?type=#{queue}"

    HTTP.get(region: region, rest: rest)
  end
end
