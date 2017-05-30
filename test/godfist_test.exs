defmodule GodfistTest do
  use ExUnit.Case

  alias Godfist.{ChampionMastery, Champion, League, Status, Masteries,
        Match, Runes}

  @sumid 24244
  @sumids [200203, 24244]
  @lasid 203629807
  @lasmatchid 460035794
  @naid 212650893
  @champid 64

  # Champion mastery tests.
  test "return information of player" do
    assert {:ok, _} = ChampionMastery.by_summoner(@sumid, :lan)
  end

  test "returns information of single champion from player" do
    {:ok, map} = ChampionMastery.by_champion(@sumid, @champid, :lan)

    assert Map.has_key?(map, "championId") == true
  end

  test "returns total mastery points from player" do
    {:ok, total} = ChampionMastery.total(@sumid, :lan)

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
    multiple = League.get_all(:lan, @sumids)

    assert {:ok, _} = single
    assert {:ok, _} = multiple
  end

  test "return information about players" do
    single = League.get_entry(:lan, @sumid)
    multiple = League.get_entry(:lan, @sumids)

    assert {:ok, _} = single
    assert {:ok, _} = multiple
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
end
