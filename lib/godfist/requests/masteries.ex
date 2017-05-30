defmodule Godfist.Masteries do
  @moduledoc false

  alias Godfist.HTTP

  @v "v3"

  def get(region, sumid) do
    rest = "/lol/platform/#{@v}/masteries/by-summoner/#{sumid}"

    HTTP.get(region: region, rest: rest)
  end
end
