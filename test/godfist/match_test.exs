defmodule Godfist.MatchTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Godfist.{Match, LeagueRates}

  @lasid 204_359_681
  @lasmatchid 460_035_794

  setup do
    bypass = Bypass.open()
    LeagueRates.start_link(bypass.port)

    {:ok, bypass: bypass}
  end

  # Matches
  test "return match stats by id", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"seasonId": 9}))
    end)

    assert {:ok, map} = Match.get_match(:las, @lasmatchid)
    assert map["seasonId"] == 9
  end

  test "return matchlist by account id", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"matches": []}))
    end)

    assert {:ok, map} = Match.matchlist(:las, @lasid, season: 8, champion: 111)
    assert is_list(map["matches"])
  end

  # TODO: Implement test
  # test "return last 20 matches from an id", %{bypass: bypass} do
  #   Bypass.expect(bypass, fn conn ->
  #     Plug.Conn.resp(conn, 200, ~s({"matches": []}))
  #   end)

  #   assert {:ok, map} = Match.recent(:las, @lasid)
  #   assert is_list(map["matches"])
  # end

  test "return timeline data from given match", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"frames": []}))
    end)

    assert {:ok, map} = Match.timeline(:las, @lasmatchid)
    assert is_list(map["frames"])
  end
end
