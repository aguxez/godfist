defmodule GodfistTest do
  @moduledoc false

  use ExUnit.Case

  alias Godfist.{ChampionMastery, Champion, League, Status, Masteries,
        Match, Runes, Spectator, Static, Summoner}

  @sumid 24_244
  @lasid 204_359_681
  @lasmatchid 460_035_794
  @naid 39_626_602
  @champid 64

  # Champion mastery tests.
  test "return information of player" do
    assert {:ok, _} = ChampionMastery.by_summoner(:lan, @sumid)
  end

  test "returns information of single champion from player" do
    {:ok, map} = ChampionMastery.by_champion(:lan, @sumid, @champid)

    assert Map.has_key?(map, "championId") == true
  end

  test "returns total mastery points from player" do
    {:ok, total} = ChampionMastery.total(:lan, @sumid)

    assert is_integer(total) == true
  end

  # Champion tests.
  test "returns list of all champions" do
    assert {:ok, _} = Champion.all(:na)
  end

  test "returns single champion information" do
    assert {:ok, _} = Champion.by_id(:las, @champid)
  end

  # League tests
  test "return league information about given players" do
    single = League.get_all(:lan, @sumid)

    assert {:ok, _} = single
  end

  test "return information about players" do
    single = League.get_entry(:lan, @sumid)

    assert {:ok, _} = single
  end

  test "return challenger league" do
    queue = [:flex_sr, :flex_tt, :solo_5]
    Enum.map queue, fn data ->
      assert {:ok, _} = League.challenger(:na, data)
    end
  end

  test "return master league" do
    queue = [:flex_sr, :solo_5]
    Enum.map queue, fn data ->
      assert {:ok, _} = League.master(:euw, data)
    end
  end

  # Status
  test "return shard data from server" do
    assert {:ok, _} = Status.shard(:ru)
  end

  # Masteries
  test "return masteries from player" do
    assert {:ok, _} = Masteries.get(:lan, @sumid)
  end

  # Matches
  test "return match stats by id" do
    assert {:ok, _} = Match.get_match(:las, @lasmatchid)
  end

  test "return matchlist by account id" do
    assert {:ok, _} = Match.matchlist(:las, @lasid, [season: 8, champion: 111])
  end

  test "return last 20 matches from an id" do
    assert {:ok, _} = Match.recent(:las, @lasid)
  end

  test "return timeline data from given match" do
    assert {:ok, _} = Match.timeline(:las, @lasmatchid)
  end

  # Runes
  test "return runes from player" do
    assert {:ok, _} = Runes.summoner(:na, @naid)
  end

  # Spectator
  test "get list of featured games" do
    assert {:ok, _} = Spectator.featured_games(:ru)
  end

  # Static
  test "returns static data of all champs" do
    assert {:ok, _} = Static.all_champs(:oce)
  end

  test "return single champion by id" do
    assert {:ok, _} = Static.champion(:oce, @champid)
  end

  test "return list of all items" do
    assert {:ok, _} = Static.all_items(:ru)
  end

  test "return single item by id" do
    assert {:ok, _} = Static.item(:ru, 1001)
  end

  test "return language strings data" do
    assert {:ok, _} = Static.lang_strings(:oce)
  end

  test "return supported languages" do
    assert {:ok, _} = Static.languages(:euw)
  end

  test "return map's data" do
    assert {:ok, _} = Static.maps(:eune)
  end

  test "return static data of masteries" do
    assert {:ok, _} = Static.all_masteries(:eune)
  end

  test "return single mastery by id" do
    assert {:ok, _} = Static.mastery(:eune, 6111)
  end

  test "return static data of profile icons" do
    assert {:ok, _} = Static.profile_icons(:oce)
  end

  test "return static data of realms" do
    assert {:ok, _} = Static.realms(:oce)
  end

  test "return runes data" do
    assert {:ok, _} = Static.all_runes(:na)
  end

  test "return single rune by id" do
    assert {:ok, _} = Static.rune(:na, 5001)
  end

  test "return summoner spells" do
    assert {:ok, _} = Static.sum_spells(:na)
  end

  test "return single spell by id" do
    assert {:ok, _} = Static.spell(:oce, 34)
  end

  test "return versions" do
    assert {:ok, _} = Static.versions(:eune)
  end

  # Summoner
  test "return summoner by account id" do
    assert {:ok, _} = Summoner.by_id(:na, @naid)
  end

  test "return summoner by name" do
    assert {:ok, _} = Summoner.by_name(:lan, "Mjólner")
  end

  test "return summoner by sumoner id" do
    assert {:ok, _} = Summoner.by_summid(:las, 12_200_604) # Summoner id
  end

  test "return id of summoner by name" do
    {:ok, id} = Summoner.get_id(:las, "Laicram")

    assert is_integer(id) == true
  end
end
