defmodule Godfist.DataDragon do
  @moduledoc """
  Module to interact with the static data provided by Data Dragon instead of
  the default one by Riot.

  The names provided for champions in this Module are case sensitive because of
  the way that Data Dragon handles it's files. For now it's up to you to get the
  champion's names correctly.
  """

  alias Godfist.{Static, DataDragon.Data}

  @v "7.11.1"
  @endpoint "https://ddragon.leagueoflegends.com/cdn"

  @doc """
  Get image of a profile icon by it's id.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.profile_icon(588)
  ```
  """
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
  def champ_splash(name, number) do
    @endpoint <> "/img/champion/splash/#{replace(name)}_#{number}.jpg"
  end

  @doc """
  Get a champion loading screen art by it's name and splash id.

  ## Example
  ```elixir
  iex> Godfist.DataDragon.champ_loading("LeeSin", 1)
  ```
  """
  def champ_loading(name, number) do
    @endpoint <> "/img/champion/loading/#{replace(name)}_#{number}.jpg"
  end

  @doc """
  Get the square image of a champion by it's name and splash id.

  ## Example
  ```elixir
  iex> Godfist.DataDragon.champ_square("Rek Sai")
  ```
  """
  def champ_square(name) do
    @endpoint <> "/#{@v}/img/champion/#{replace(name)}.png"
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
  def passive(name) do
    {:ok, champ} = Data.single_champ(replace(name))
    {:ok, data} = Static.champion(:oce, champ["data"][replace(name)]["key"], filter: "passive")
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
  def rune(id) do
    @endpoint <> "/#{@v}/img/rune/#{id}.png"
  end

  # Priv for replacing champion names.
  defp replace(url) do
    url
    |> String.replace(" ", "")
    |> String.replace("'", "")
  end
end
