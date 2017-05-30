defmodule Godfist.ChampionMastery do
  @moduledoc false

  alias Godfist.HTTP

  @v "v3"

  def by_summoner(id, region) do
    rest = "/lol/champion-mastery/#{@v}/champion-masteries/by-summoner/#{id}"

    HTTP.get(region: region, rest: rest)
  end

  def by_champion(id, champ_id, region) do
    rest = "/lol/champion-mastery/#{@v}/champion-masteries/by-summoner/#{id}/by-champion/#{champ_id}"

    HTTP.get(region: region, rest: rest)
  end

  def total(id, region) do
    rest = "/lol/champion-mastery/#{@v}/scores/by-summoner/#{id}"

    HTTP.get(region: region, rest: rest)
  end
end
