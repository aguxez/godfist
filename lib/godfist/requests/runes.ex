defmodule Godfist.Runes do
  @moduledoc false

  alias Godfist.HTTP

  @v "v3"

  def summoner(region, id) do
    rest = "/lol/platform/#{@v}/runes/by-summoner/#{id}"

    HTTP.get(region: region, rest: rest)
  end
end
