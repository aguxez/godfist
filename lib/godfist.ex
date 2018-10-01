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
    token: "YOUR API KEY"
  ```
  """

  alias Godfist.{Summoner, Match, Spectator, Champion, DataDragon, Static}

  @doc """
  Get the account id of a player by it's region and name.

  Refer to `Godfist.Summoner.get_id/2`
  """
  @spec get_account_id(atom, String.t()) :: {:ok, integer} | {:error, String.t()}
  def get_account_id(region, name) do
    {_, id} = Cachex.fetch(:id_cache, "id_#{inc(name)}", fn ->
      {:ok, id} = Summoner.get_id(region, name)
      {:commit, id}
    end)
    {:ok, id}
  end

  defp set_cache(name, key, value, opts \\ []) do
    case Application.get_env(:godfist, :rates) do
      :test -> :ok
      _ -> Cachex.put(name, key, value, opts)
    end
  end

  @doc """
  Get the summoner id of a player by it's name and region:

  ## Example

  ```elixir
  iex> Godfist.get_summid(:lan, "SummonerName")
  ```
  """
  @spec get_summid(atom, String.t()) :: {:ok, integer} | {:error, String.t()}
  def get_summid(region, name) do
    {_, summid} = Cachex.fetch(:summid_cache, "summid_#{inc(name)}", fn ->
      {:ok, %{"id" => summid}} = Summoner.by_name(region, name)
      {:commit, summid}
    end)
    {:ok, summid}
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
  @spec matchlist(atom, String.t(), Keyword.t()) :: {:ok, map} | {:error, String.t()}
  def matchlist(region, name, opts \\ []) do
    with {:ok, account_id} <- get_account_id(region, name),
         {:ok, matches} <- Match.matchlist(region, account_id, opts) do
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
  @spec active_game(atom, String.t()) :: {:ok, map} | {:error, String.t()}
  def active_game(region, name) do
    with {:ok, id} <- get_summid(region, name),
         {:ok, match} <- Spectator.active_game(region, id) do
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
  @spec all_champs(atom, Keyword.t()) :: {:ok, map} | {:error, String.t()}
  def all_champs(region, opts \\ []) do
    Champion.all(region, opts)
  end

  @doc """
  Get a specific champion by id.

  Refer to `Godfist.Champion.by_id/2`
  """
  @spec champion(atom, integer) :: {:ok, map} | {:error, String.t()}
  def champion(region, id) do
    {_, champ} = Cachex.fetch(:champion, "champ_#{id}", fn ->
      {:ok, champ} = Champion.by_id(region, id)
      {:commit, champ}
    end)
    {:ok, champ}
  end

  @doc """
  Get a specific champion by it's name. This is useful to work with `Godfist.DataDragon` endpoints.

  ## Example

  ```elixir
  iex> Godfist.champion_by_name("リー・シン", :japanese)
  iex> Godfist.champion_by_name(["Lee Sin", "Rek'Sai", "Nocturne"])
  ```
  """
  @spec champion_by_name(list, atom) :: list | MatchError
  def champion_by_name(champions, locale \\ :us)

  def champion_by_name(champions, locale) when is_list(champions) do
    champions
    |> Stream.map(fn champs -> champion_by_name(champs, locale) end)
    |> Enum.to_list()
  end

  @spec champion_by_name(String.t(), atom) :: {String.t(), map} | MatchError
  def champion_by_name(name, locale) do
    {_, champs} = Cachex.fetch(:all_champs, "all_champs", fn ->
      {:ok, champs} = DataDragon.Data.champions(locale)
      {:commit, champs}
    end)
    find_single_champ(champs, name)
  end

  @doc """
  Get a champion's information by it's ID.

  ## Example

  ```elixir
  iex> Godfist.champion_by_id(:lan, 64)
  ```
  """
  @spec champion_by_id(atom, integer) :: {:ok, map} | {:error, String.t()}
  def champion_by_id(region, champ_id) do
    {_, champs} = Cachex.fetch(:static_champs, "static_champs", fn ->
      {:ok, champs} = Static.all_champs(region, dataById: true, tags: "keys")
      {:commit, champs}
    end)
    find_champ_by_id(champs, champ_id)
  end

  defp find_champ_by_id(champs, champ_id) do
    {:ok, Map.get(champs["data"], to_string(champ_id))["name"]}
  end

  # Makes everything 1 word, "inc" is short for inconsistency.
  defp inc(name), do: String.replace(name, " ", "@")

  defp find_single_champ(list, name) do
    list["data"]
    |> Stream.map(& &1)
    |> Enum.to_list()
    |> Enum.find(fn {_k, v} -> v["name"] == name end)
  end

  @doc """
  Find similar champs to the query.

  ## Example

  ```elixir
  iex> Godfist.find_similar("Noc", :us)
  iex> Godfist.find_similar("L")
  ```
  """
  @spec find_similar(String.t(), atom) :: list | {:error, String.t()}
  def find_similar(name, locale \\ :us) do
    {_, map} = Cachex.fetch(:all_champs, "all_champs", fn ->
      {:ok, %{"data" => map}} = DataDragon.Data.champions(locale)
      {:commit, map}
    end)
    find_champs(map, name)
  end

  # Map through the champ list and filter the ones that are similar to the given
  # name.
  defp find_champs(champ_list, name) do
    Enum.filter(champ_list, fn {_k, v} -> String.contains?(v["name"], name) end)
  end
end
