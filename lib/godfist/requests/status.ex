defmodule Godfist.Status do
  @moduledoc false

  alias Godfist.HTTP

  @v "v3"

  # Returns shard-data of a specific server
  def shard(region) do
    rest = "/lol/status/#{@v}/shard-data"

    HTTP.get(region: region, rest: rest)
  end
end
