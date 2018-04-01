defmodule Godfist.Status do
  @moduledoc """
  Status endpoint.
  """

  alias Godfist.LeagueRates

  @v "v3"

  # Returns shard-data of a specific server

  @doc """
  Return shard data.
  """
  @spec shard(atom) :: {:ok, map} | {:error, String.t()}
  def shard(region) do
    rest = "/lol/status/#{@v}/shard-data"

    LeagueRates.handle_rate(region, rest, :other)
  end
end
