defmodule Godfist.Runes do
  @moduledoc """
  Module to interact with the Runes endpoint.
  """

  alias Godfist.HTTP

  @v "v3"

  @doc """
  Get runes of a given summoner by id.

  ## Example

  ```elixir
  iex> Godfist.Runes.summoner(:ru, summid)
  ```
  """
  @spec summoner(atom, Integer) :: {:ok, map} | {:error, String.t}
  def summoner(region, id) do
    rest = "/lol/platform/#{@v}/runes/by-summoner/#{id}"

    HTTP.get(region: region, rest: rest)
  end
end
