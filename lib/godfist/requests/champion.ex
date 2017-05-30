defmodule Godfist.Champion do
  @moduledoc false

  alias Godfist.HTTP

  @v "v3"

  def all(region, opts \\ []) do
    free_to_play = Keyword.get(opts, :ftp, false)
    rest = "/lol/platform/#{@v}/champions?freeToPlay=#{free_to_play}"

    HTTP.get(region: region, rest: rest)
  end

  def by_id(region, id) do
    rest = "/lol/platform/#{@v}/champions/#{id}"

    HTTP.get(region: region, rest: rest)
  end
end
