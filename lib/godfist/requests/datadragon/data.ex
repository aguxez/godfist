defmodule Godfist.DataDragon.Data do
  @moduledoc """
  Interact with the data endpoints from DataDragon in English.
  Each function must be passed a locale as an atom, you can consult the available
  languages on `Godfist.Static.languages/1`.

  Default language is english(United States) if none is specified.

  These are all available languages in a list. `[:argentina, :australia, :china,
  :czech, :french, :german, :greek, :hungarian, :indonesian, :italian, :japanese,
  :korean, :malay, :malaysia, :mexico, :philippines, :poland, :polish,
  :portuguese, :romanian, :russian, :singapore, :spain, :taiwan, :thai, :turkish,
  :uk, :us, :vietnamese]`

  Almost every locale has the name of it's country because I guess there are
  variations regarding languages on each country.
  """

  alias Godfist.HTTP

  @dragon :dragon
  @endpoint "/7.11.1/data"
  @languages %{
    czech: "cs_CZ",
    german: "de_DE",
    greek: "el_GR",
    australia: "en_AU",
    uk: "en_GB",
    philippines: "en_PH",
    poland: "en_PL",
    singapore: "en_SG",
    us: "en_US",
    argentina: "es_AR",
    spain: "es_ES",
    mexico: "es_MX",
    french: "fr_FR",
    hungarian: "hu_HU",
    indonesian: "id_ID",
    italian: "it_IT",
    japanese: "ja_JP",
    korean: "ko_KR",
    malay: "ms_MY",
    polish: "pl_PL",
    portuguese: "pt_PR",
    romanian: "ro_RO",
    russian: "ru_RU",
    thai: "th_TH",
    turkish: "tr_TR",
    vietnamese: "vn_VN",
    china: "zh_CN",
    malaysia: "zh_MY",
    taiwan: "zh_TW"
  }

  @doc """
  Get information about profile icons.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.Data.icons(:greek)
  ```
  """
  def icons(locale \\ :us) do
    lang = get_loc(locale)
    rest = @endpoint <> "/#{lang}/profileicon.json"

    HTTP.get(region: @dragon, rest: rest)
  end

  @doc """
  Get information about champions.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.Data.champions(:us)
  ```
  """
  def champions(locale \\ :us) do
    lang = get_loc(locale)
    rest = @endpoint <> "/#{lang}/champion.json"

    HTTP.get(region: @dragon, rest: rest)
  end

  @doc """
  Get information about a single champion.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.Data.single_champ("Aatrox", :japanese)
  ```
  """
  def single_champ(name, locale \\ :us) do
    lang = get_loc(locale)
    rest = @endpoint <> "/#{lang}/champion/#{name}.json"

    HTTP.get(region: @dragon, rest: rest)
  end

  @doc """
  Get information about the items.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.Data.items(:spain)
  ```
  """
  def items(locale \\ :us) do
    lang = get_loc(locale)
    rest = @endpoint <> "/#{lang}/item.json"

    HTTP.get(region: @dragon, rest: rest)
  end

  @doc """
  Get information about masteries.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.Data.masteries()
  ```
  """
  def masteries(locale \\ :us) do
    lang = get_loc(locale)
    rest = @endpoint <> "/#{lang}/mastery.json"

    HTTP.get(region: @dragon, rest: rest)
  end

  @doc """
  Get information about runes.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.Data.runes(:japanese)
  ```
  """
  def runes(locale \\ :us) do
    lang = get_loc(locale)
    rest = @endpoint <> "/#{lang}/rune.json"

    HTTP.get(region: @dragon, rest: rest)
  end

  @doc """
  Get information about summoner spells.

  ## Example

  ```elixir
  iex> Godfist.DataDragon.Data.summ_spells()
  ```
  """
  def summ_spells(locale \\ :us) do
    lang = get_loc(locale)
    rest = @endpoint <> "/#{lang}/summoner.json"

    HTTP.get(region: @dragon, rest: rest)
  end


  # priv to get locale
  defp get_loc(locale), do: Map.get(@languages, locale)
end
