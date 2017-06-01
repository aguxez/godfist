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
  def all_champs(region, opts \\ []) do
    tags = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/champions&tags=#{tags}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a single champion by id.

  Refer to `all_champs/2` for a list of options.
  """
  def champion(region, id, opts \\ []) do
    filter = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/champions/#{id}?tags=#{filter}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a list of all items.

  One option must be passed, otherwise "all" is returned.

  Pass on the `:filter` key with value of:

  * `all`
  * `colloq`
  * `consumeOnFull`
  * `consumed`
  * `depth`
  * `from`
  * `gold`
  * `groups`
  * `hideFromAll`
  * `image`
  * `inStore`
  * `into`
  * `maps`
  * `requiredChampion`
  * `sanitizedDescription`
  * `specialRecipe`
  * `stacks`
  * `stats`
  * `tags`
  * `tree`
  """
  def all_items(region, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/items&tags=#{tag}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a single item by id.

  Refer to `all_items/2` for a list of options.
  """
  def item(region, id, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/items/#{id}&tags=#{tag}"

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

  Opts is atom `:filter` with a value of one of:

  * `all` (Default)
  * `image`
  * `masteryTree`
  * `prereq`
  * `ranks`
  * `sanitizedDescription`
  * `tree`
  """
  def all_masteries(region, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/masteries&tags=#{tag}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a single mastery by id.

  Refer to `all_masteries/2` for a list of options.
  """
  def mastery(region, id, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/masteries/#{id}&tags=#{tag}"

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

  Options are given with an atom `:filter` as key and values are:

  * `all` (Default)
  * `image`
  * `sanitizedDescription`
  * `stats`
  * `tags`
  """
  def all_runes(region, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/runes&tags=#{tag}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get information about a single rune by id.

  Reger to `all_runes/2` for a list of options.
  """
  def rune(region, id) do
    rest = @endpoint <> "/runes/#{id}"

    HTTP.get(region: region, rest: rest)
  end

  @doc """
  Get a list of all summoner spells.

  Options are given with an atom `:filter` as key and values are:

  * `all` (Default)
  * `cooldown`
  * `cooldownBurn`
  * `cost`
  * `costBurn`
  * `costType`
  * `effect`
  * `effectBurn`
  * `image`
  * `key`
  * `leveltip`
  * `maxrank`
  * `modes`
  * `range`
  * `rangeBurn`
  * `resource`
  * `sanitizedDescription`
  * `sanitizedTooltip`
  * `tooltip`
  * `vars`
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
