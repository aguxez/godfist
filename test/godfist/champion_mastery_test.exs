defmodule Godfist.ChampionMasteryTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Godfist.{LeagueRates, ChampionMastery}

  @sumid 24_244
  @champid 64

  setup do
    bypass = Bypass.open()
    LeagueRates.start_link(bypass.port)

    {:ok, bypass: bypass}
  end

  # Champion mastery tests.
  test "return information of player", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({}))
    end)

    assert {:ok, _} = ChampionMastery.by_summoner(:lan, @sumid)
  end

  test "returns information of single champion from player", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"championId": 64}))
    end)

    {:ok, map} = ChampionMastery.by_champion(:lan, @sumid, @champid)
    assert Map.has_key?(map, "championId") == true
  end

  test "returns total mastery points from player", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s(123441))
    end)

    {:ok, total} = ChampionMastery.total(:lan, @sumid)
    assert is_integer(total) == true
  end
end
