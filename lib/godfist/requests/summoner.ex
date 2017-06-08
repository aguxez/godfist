defmodule Godfist.Summoner do
  @moduledoc """
  Module to interact with the Summoner endpoint.
  """

  alias Godfist.HTTP

  @endpoint "/lol/summoner/v3/summoners"

  @doc """
  Get a summoner's data by account id.

  ## Example

  ```elixir
  iex> Godfist.Summoner.by_id(:lan, id)
  ```
  """
  @spec by_id(atom, integer) :: {:ok, map} | {:error, String.t}
  def by_id(region, id) do
    rest = @endpoint <> "/by-account/#{id}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a summoner's data by account name.

  ## Example

  ```elixir
  iex> Godfist.Summoner.by_name(:oce, name)
  ```
  """
  @spec by_name(atom, String.t) :: {:ok, map} | {:error, String.t}
  def by_name(region, name) do
    rest = @endpoint <> "/by-name/#{name}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a summoner's data by summoner id.
  Summoner id and Account id are not the same. They're given as `id` and
  `accountId` respectively.

  ## Example

  ```elixir
  iex> Godfist.Summoner.by_summid(:jp, summonerid)
  ```
  """
  @spec by_summid(atom, integer) :: {:ok, map} | {:error, String.t}
  def by_summid(region, id) do
    # This is basically the same as above
    # Just that it uses summoner id instead of account id
    rest = @endpoint <> "/#{id}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get the account id of a player directly by name.

  ## Example

  ```elixir
  iex> Godfist.Summoner.get_id(:jp, name)
  ```
  """
  @spec get_id(atom, String.t) :: {:ok, integer} | {:error, String.t}
  def get_id(region, name) do
    # Get the id of the player directly by name.
    rest = @endpoint <> "/by-name/#{name}"

    # I can probably do this in a more elegant way?
    case HTTP.get(region: region, rest: rest) do
      {:ok, "Not found"} ->
        {:error, "Summoner not found"}
      {:ok, summ} ->
        {:ok, summ["accountId"]}
      {:error, reason} ->
        {:error, reason}
    end
  end
end
