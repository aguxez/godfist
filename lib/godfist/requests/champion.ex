defmodule Godfist.Champion do
  @moduledoc """
  Module to interact with the Champions endpoint
  """

  alias Godfist.LeagueRates

  @endpoint "/lol/platform/v3/champions/"

  @doc """
  Get a list of all champions.

  Options are:
  * `:ftp`, Filter Free to play champions.

  ## Example

  ```elixir
  iex> Godfist.Champion.all(:lan, ftp: true)
  ```
  """
  @spec all(atom, Keyword.t) :: {:ok, map} | {:error, String.t}
  def all(region, opts \\ []) do
    free_to_play = Keyword.get(opts, :ftp, false)
    rest = @endpoint <> "?freeToPlay=#{free_to_play}"

    LeagueRates.handle_rate(region, rest, :champion_masteries_runes)
  end

  @doc """
  Get a single champion by id.

  ## Example
  ```elixir
  iex> Godfist.Champion.by_id(:na, 64)
  ```
  """
  @spec by_id(atom, integer) :: {:ok, map} | {:error, String.t}
  def by_id(region, id) do
    rest = @endpoint <> "#{id}"

    LeagueRates.handle_rate(region, rest, :champion_masteries_runes)
  end
end
