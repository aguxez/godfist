defmodule Godfist do
  @moduledoc """
  Godfist is a wrapper for the League of Legends ReST API written in Elixir.

  There are some endpoints that I'll be adding later which will be the static
  data from Data Dragon and Tournament support.

  Every function requires that you pass the region to execute the request to
  since Riot uses that to Rate limit the usage of the api. Every region should
  be passed as an Atom, remember that :P

  Set your api key in your `config.exs` file with the given params.

  ```elixir
  config :godfist,
  token: "YOUR API KEY",
  time: 1000, # This is the minimum default from Riot, set this time in miliseconds.
  amount: 10 # Amount of request limit, default minium is 10 each 10 seconds.
  ```
  """

  alias Godfist.{Summoner}

  @doc """
  Get the account id of a player by it's region and name.

  Refer to `Godfist.Summoner.get_id/2`
  """
  @spec get_account_id(atom, String.t) :: {:ok, id} | {:error, reason}
  def get_account_id(region, name) do
    with {:missing, nil} <- Cachex.get(:id_cache, "id_#{inc(name)}"),
         {:ok, id} when is_integer(id) <- Summoner.get_id(region, name) do
      Cachex.set!(:id_cache, "id_#{inc(name)}", id)
      {:ok, id}
    else
      {:ok, id} ->
        {:ok, id}
      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Get the summoner id of a player by it's name and region:

  ## Example

  ```elixir
  iex> Godfist.get_summid(:lan, "SummonerName")
  ```
  """
  @spec get_summid(atom, String.t) :: {:ok, summid} | {:error, reason}
  def get_summid(region, name) do
    with {:missing, nil} <- Cachex.get(:summid_cache, "summid_#{inc(name)}") do
      {:ok, %{"id" => summid}} = Godfist.Summoner.by_name(region, name)
      Cachex.set!(:summid_cache, "summid_#{inc(name)}", summid)
      {:ok, summid}
    else
      {:ok, summid} ->
        {:ok, summid}
      {:error, reason} ->
        {:error, reason}
    end
  end

  # Make everything 1 word, "inc" is short for inconsistency.
  defp inc(name) do
    String.replace(name, " ", "@")
  end

  @doc """
  Get matchlist of a player by it's region and name.

  Same as `Godfist.Match.matchlist/2` (Check for a list of options)
  but you don't have to provide the summoner id directly.

  ## Example

  ```elixir
  iex> Godfist.matchlist(:lan, "SummonerName")
  ```
  """
  @spec matchlist(atom, String.t, Keyword.t) :: {:ok, matches} | {:error, reason}
  def matchlist(region, name, opts \\ []) do
    with {:ok, account_id} <- Godfist.get_account_id(region, name),
         {:ok, matches} <- Godfist.Match.matchlist(region, account_id, opts) do
      {:ok, matches}
    else
      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Get active game of a given player by region and name.

  ## Example

  ```elixir
  iex> Godfist.active_game(:na, "Summoner name")
  ```
  """
  @spec active_game(atom, String.t) :: {:ok, match} | {:error, reason}
  def active_game(region, name) do
    with {:ok, id} <- Godfist.get_summid(region, name),
         {:ok, match} <- Godfist.Spectator.active_game(region, id) do
      {:ok, match}
    else
      {:error, reason} ->
        {:error, reason}
    end
  end
end
