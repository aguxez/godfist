defmodule Godfist.Champion do
  @moduledoc """
  Module to interact with the Champions endpoint
  """

  alias Godfist.HTTP

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
  def all(region, opts \\ []) do
    free_to_play = Keyword.get(opts, :ftp, false)
    rest = @endpoint <> "?freeToPlay=#{free_to_play}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a single champion by id.

  ## Example
  ```elixir
  iex> Godfist.Champion.by_id(:na, 64)
  ```
  """
  def by_id(region, id) do
    rest = @endpoint <> "#{id}"

    HTTP.get(region: region, rest: rest)
  end
end
