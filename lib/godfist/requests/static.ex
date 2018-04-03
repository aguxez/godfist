defmodule Godfist.Static do
  @moduledoc """
  Module to interact with the Static data provided by Riot.
  I'm not going to provide examples in this Module unless it's necessary.
  Just pass each region as an atom and id if it requires it.

  On some of these functions I could have provided the ids as options and use
  the same function name but I thought that explicitly telling that you want
  a single rune or mastery is a better id so... You can do it like this intead.
  """

  alias Godfist.LeagueRates

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
  @spec all_champs(atom, Keyword.t()) :: {:ok, map} | {:error, String.t()}
  def all_champs(region, opts \\ []) do
    tags = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/champions?champListData=#{tags}"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Get a single champion by id.

  Refer to `all_champs/2` for a list of options.
  """
  @spec champion(atom, integer, Keyword.t()) :: {:ok, map} | {:error, String.t()}
  def champion(region, id, opts \\ []) do
    filter = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/champions/#{id}?champData=#{filter}"

    LeagueRates.handle_rate(region, rest, :static)
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
  @spec all_items(atom, Keyword.t()) :: {:ok, map} | {:error, String.t()}
  def all_items(region, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/items?itemListData=#{tag}"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Get a single item by id.

  Refer to `all_items/2` for a list of options.
  """
  @spec item(atom, integer, Keyword.t()) :: {:ok, map} | {:error, String.t()}
  def item(region, id, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/items/#{id}?tags=#{tag}"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Retrieve language strings data.
  """
  @spec lang_strings(atom) :: {:ok, map} | {:error, String.t()}
  def lang_strings(region) do
    rest = @endpoint <> "/language-strings"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Get support languages data.
  """
  @spec languages(atom) :: {:ok, map} | {:error, String.t()}
  def languages(region) do
    rest = @endpoint <> "/languages"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Get information about all maps.
  """
  @spec maps(atom) :: {:ok, map} | {:error, String.t()}
  def maps(region) do
    rest = @endpoint <> "/maps"

    LeagueRates.handle_rate(region, rest, :static)
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
  @spec all_masteries(atom, Kwyrod.t()) :: {:ok, map} | {:error, String.t()}
  def all_masteries(region, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/masteries?tags=#{tag}"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Get a single mastery by id.

  Refer to `all_masteries/2` for a list of options.
  """
  @spec mastery(atom, integer, Kwyrod.t()) :: {:ok, map} | {:error, String.t()}
  def mastery(region, id, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/masteries/#{id}?masteryData=#{tag}"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Get a list of all profile icons.
  """
  @spec profile_icons(atom) :: {:ok, map} | {:error, String.t()}
  def profile_icons(region) do
    rest = @endpoint <> "/profile-icons"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Retrieve realm data.
  """
  @spec realms(atom) :: {:ok, map} | {:error, String.t()}
  def realms(region) do
    rest = @endpoint <> "/realms"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Retrieves reforged rune path list.
  """
  @spec reforged_runes_path(atom) :: {:ok, list} | {:error, String.t()}
  def reforged_runes_path(region) do
    rest = @endpoint <> "/reforged-rune-paths"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Retrieves reforged rune path by ID.
  """
  @spec reforged_rune_path_by_id(atom, integer) :: {:ok, list} | {:error, String.t()}
  def reforged_rune_path_by_id(region, id) do
    rest = @endpoint <> "/reforged-rune-paths/#{id}"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Retrieves reforged runes list.
  """
  @spec reforged_runes(atom) :: {:ok, list} | {:error, String.t()}
  def reforged_runes(region) do
    rest = @endpoint <> "/reforged-runes"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Retrieves reforged rune by ID.
  """
  @spec reforged_rune_by_id(atom, integer) :: {:ok, list} | {:error, String.t()}
  def reforged_rune_by_id(region, id) do
    rest = @endpoint <> "/reforged-runes/#{id}"

    LeagueRates.handle_rate(region, rest, :static)
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
  @spec all_runes(atom, Keyword.t()) :: {:ok, map} | {:error, String.t()}
  def all_runes(region, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/runes?runeListData=#{tag}"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Get information about a single rune by id.

  Reger to `all_runes/2` for a list of options.
  """
  @spec rune(atom, integer, Keyword.t()) :: {:ok, map} | {:error, String.t()}
  def rune(region, id, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/runes/#{id}?tags=#{tag}"

    LeagueRates.handle_rate(region, rest, :static)
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
  @spec sum_spells(atom, Keyword.t()) :: {:ok, map} | {:error, String.t()}
  def sum_spells(region, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/summoner-spells?spellListData=#{tag}&dataById=true"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Get a single spell by id.

  Refer to `sum_spells/1` for a list of options
  """
  @spec spell(atom, integer, Keyword.t()) :: {:ok, map} | {:error, String.t()}
  def spell(region, id, opts \\ []) do
    tag = Keyword.get(opts, :filter, "all")
    rest = @endpoint <> "/summoner-spells/#{id}?spellData=#{tag}"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Retrieves full tarball link
  """
  @spec tarball_links(atom) :: {:ok, String.t()} | {:error, String.t()}
  def tarball_links(region) do
    rest = @endpoint <> "/tarball-links"

    LeagueRates.handle_rate(region, rest, :static)
  end

  @doc """
  Get version data.
  """
  @spec versions(atom) :: {:ok, map} | {:error, String.t()}
  def versions(region) do
    rest = @endpoint <> "/versions"

    LeagueRates.handle_rate(region, rest, :static)
  end
end
