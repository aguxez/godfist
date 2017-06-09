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
  @spec get_account_id(atom, String.t) :: {:ok, integer} | {:error, String.t}
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
  @spec get_summid(atom, String.t) :: {:ok, integer} | {:error, String.t}
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

  @doc """
  Get matchlist of a player by it's region and name.

  Same as `Godfist.Match.matchlist/3` (Check for a list of options)
  but you don't have to provide the summoner id directly.

  ## Example

  ```elixir
  iex> Godfist.matchlist(:lan, "SummonerName")
  ```
  """
  @spec matchlist(atom, String.t, Keyword.t) :: {:ok, map} | {:error, String.t}
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
  @spec active_game(atom, String.t) :: {:ok, map} | {:error, String.t}
  def active_game(region, name) do
    with {:ok, id} <- Godfist.get_summid(region, name),
         {:ok, match} <- Godfist.Spectator.active_game(region, id) do
      {:ok, match}
    else
      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Get all champs.

  Refer to `Godfist.Champion.all/2` for option.
  """
  @spec all_champs(atom, Keyword.t) :: {:ok, map} | {:error, String.t}
  def all_champs(region, opts \\ []) do
    Godfist.Champion.all(region, opts)
  end

  @doc """
  Get a specific champion by id.

  Refer to `Godfist.Champion.by_id/2`
  """
  @spec champion(atom, integer) :: {:ok, map} | {:error, String.t}
  def champion(region, id) do
    with {:missing, nil} <- Cachex.get(:champion, "champ_#{id}"),
         {:ok, champ} <- Godfist.Champion.by_id(region, id) do
      Cachex.set!(:champion, "champ_#{id}", champ)
      {:ok, champ}
    else
      {:ok, champ} ->
        {:ok, champ}
      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Get a specific champion it's name. This is useful to work with the `Godfist.DataDragon` endpoints.

  ## Example

  ```elixir
  iex> Godfist.champion_by_name("Lee Sin", :japanese)
  iex> Godfist.champion_by_name(["Lee Sin", "Rek'Sai", "Nocturne"])
  ```
  """
  def champion_by_name(champions, locale \\ :us)

  @spec champion_by_name(list, atom) :: list | MatchError
  def champion_by_name(champions, locale) when is_list(champions) do
    champions
    |> Stream.map(fn champs -> champion_by_name(champs, locale) end)
    |> Enum.to_list
  end

  @spec champion_by_name(String.t, atom) :: {String.t, map} | MatchError
  def champion_by_name(name, locale) do
    case Cachex.get(:champ_name, "champ_#{inc(name)}_#{locale}") do
      {:missing, nil} ->
        {:ok, champs} = Godfist.DataDragon.Data.champions(locale)

        map =
          champs["data"]
          |> Stream.map(&(&1))
          |> Enum.to_list
          |> Enum.find(fn{_k, v} -> v["name"] == name end)


        Cachex.set!(:champ_name, "champ_#{inc(name)}_#{locale}", map)

        # I'm just destructuring the tuple into two variables here, that's the
        # value to return.
        {name, map} = map
        {name, map}
      {:ok, map} ->
        {name, map} = map
        {name, map}
      {:error, reason} ->
        {:error, reason}
    end
  end

    # Make everything 1 word, "inc" is short for inconsistency.
  defp inc(name) do
    String.replace(name, " ", "@")
  end
end
