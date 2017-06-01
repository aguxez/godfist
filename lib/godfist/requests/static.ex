defmodule Godfist.Static do
  @moduledoc """
  Module to interact with the Static data provided by Riot.
  I'm not going to provide examples in this Module unless it's necessary.
  Just pass each region as an atom and id if it requires it.

  On some of these functions I could have provided the ids as options and use
  the same function name but I thought that explicitly telling that you want
  a single rune or mastery is a better id so... You can do it like this intead.
  """

  alias Godfist.HTTP

  @endpoint "/lol/static-data/v3"

  @doc """
  Get a list of all champs.
  """
  def all_champs(region) do
    rest = @endpoint <> "/champions"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a single champion by id.

  One option must be passed, otherwise "all" is returned.
  Options are given with the `:filter` key with one of these values.

  * `all`
  * `allytips`
  * `altimages`
  * `blurb`
  * `enemytips`
  * `image`
  * `info`
  * `lore`
  * `partype`
  * `passive`
  * `recommended`
  * `skins`
  * `spells`
  * `stats`
  * `tags`
  """
  def champion(region, id, opts \\ [filter: "all"]) do
    filter = Keyword.get(opts, :filter)
    rest = @endpoint <> "/champions/#{id}?champData=#{filter}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a list of all items.
  """
  def all_items(region) do
    rest = @endpoint <> "/items"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a single item by id.
  """
  def item(region, id) do
    rest = @endpoint <> "/items/#{id}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Retrieve language strings data.
  """
  def lang_strings(region) do
    rest = @endpoint <> "/language-strings"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get support languages data.
  """
  def languages(region) do
    rest = @endpoint <> "/languages"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get information about all maps.
  """
  def maps(region) do
    rest = @endpoint <> "/maps"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a list of all masteries.
  """
  def all_masteries(region) do
    rest = @endpoint <> "/masteries"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a single mastery by id.
  """
  def mastery(region, id) do
    rest = @endpoint <> "/masteries/#{id}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a list of all profile icons.
  """
  def profile_icons(region) do
    rest = @endpoint <> "/profile-icons"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Retrieve realm data.
  """
  def realms(region) do
    rest = @endpoint <> "/realms"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a list of all runes.
  """
  def all_runes(region) do
    rest = @endpoint <> "/runes"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get information about a single rune by id.
  """
  def rune(region, id) do
    rest = @endpoint <> "/runes/#{id}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a list of all summoner spells.
  """
  def sum_spells(region) do
    rest = @endpoint <> "/summoner-spells"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a single spell by id.
  """
  def spell(region, id) do
    rest = @endpoint <> "/summoner-spells/#{id}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get version data.
  """
  def versions(region) do
    rest = @endpoint <> "/versions"

    HTTP.get(region: region, rest: rest)
  end
end
