defmodule Godfist.DataDragon do
  @moduledoc """
  Module to interact with the static data provided by Data Dragon instead of
  the default one by Riot.

  The names provided for champions in this Module are case sensitive because of
  the way that Data Dragon handles it's files. For now it's up to you to get the
  champion's names correctly.
  """

  alias Godfist.{Static, DataDragon.Data}

  @v "7.24.2"
  @endpoint "https://ddragon.leagueoflegends.com/cdn"

  @doc """
  Get image of a profile icon by it's id.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.profile_icon(588)
  ```
  """
  @spec profile_icon(integer) :: String.t
  def profile_icon(id) do
    @endpoint <> "/#{@v}/img/profileicon/#{id}.png"
  end

  @doc """
  Get champion splash arts by name and splash art number.

  ## Example
  ```elixir
  iex> Godfist.DataDragon.champ_splash("Aatrox", 0)
  ```
  """
  @spec champ_splash(String.t, integer) :: String.t
  def champ_splash(name, number) do
    @endpoint <> "/img/champion/splash/#{get_name(name)}_#{number}.jpg"
  end

  @doc """
  Get a champion loading screen art by it's name and splash id.

  ## Example
  ```elixir
  iex> Godfist.DataDragon.champ_loading("LeeSin", 1)
  ```
  """
  @spec champ_loading(String.t, integer) :: String.t
  def champ_loading(name, number \\ 0) do
    @endpoint <> "/img/champion/loading/#{get_name(name)}_#{number}.jpg"
  end

  @doc """
  Get the square image of a champion by it's name and splash id.

  ## Example
  ```elixir
  iex> Godfist.DataDragon.champ_square("Rek Sai")
  ```
  """
  @spec champ_square(String.t) :: String.t
  def champ_square(name) do
    @endpoint <> "/#{@v}/img/champion/#{get_name(name)}.png"
  end

  @doc """
  Get a passive ability.

  Note: For now I can take care of spaces and punctuation but the name itself
  has to be written correctly(case sensitive) otherwise Data Dragon will return
  a 404 since I don't exactly know how their files are handled. I.E. In the URL
  you can have RekSai (which is valid) but KhaZix is not valid, instead is Khazix
  so please, case sensitive until I find a way to make this simpler.

  ## Example
  ```elixir
  iex> Godfist.DataDragon.get_passive("Lee Sin")
  ```
  """
  @spec passive(String.t) :: String.t
  def passive(name) do
    {:ok, champ} = Data.single_champ(get_name(name))
    {:ok, data} = Static.champion(:oce, champ["data"][get_name(name)]["key"], filter: "passive")
    data = data["passive"]["image"]["full"]

    @endpoint <> "/#{@v}/img/passive/#{data}"
  end

  @doc """
  Get an ability from a champion by it's name.

  Refer to `passive/1` on how to get spell name.

  ## Example
  ```elixir
  iex> Godfist.DataDragon.ability("FlashFrost")
  ```
  """
  @spec ability(String.t) :: String.t
  def ability(name) do
    rep = String.replace(name, " ", "")
    @endpoint <> "/#{@v}/img/spell/#{rep}.png"
  end

  @doc """
  Get summoner spells.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.summ_spell("Heal")
  ```
  """
  @spec summ_spell(String.t) :: String.t
  def summ_spell(name) do
    @endpoint <> "/#{@v}/img/spell/Summoner#{String.capitalize(name)}.png"
  end

  @doc """
  Get an item by it's id.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.item(1001)
  ```
  """
  @spec item(integer) :: String.t
  def item(id) do
    @endpoint <> "/#{@v}/img/item/#{id}.png"
  end

  @doc """
  Get a mastery by it's id.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.mastery(6111)
  ```
  """
  @spec mastery(integer) :: String.t
  def mastery(id) do
    @endpoint <> "/#{@v}/img/mastery/#{id}.png"
  end

  @doc """
  Get a rune by it's id.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.rune(8001)
  ```
  """
  @spec rune(integer) :: String.t
  def rune(id) do
    @endpoint <> "/#{@v}/img/rune/#{id}.png"
  end

  # Get champion Data Dragon champion name from in-game champion name.
  defp get_name(champion) do
    {name, _map} = Godfist.champion_by_name(champion)
    name
  end
end
