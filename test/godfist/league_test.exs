defmodule Godfist.LeagueTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Godfist.{League, LeagueRates}

  @sumid 24_244

  setup do
    bypass = Bypass.open()
    LeagueRates.start_link(bypass.port)

    {:ok, bypass: bypass}
  end

  # League tests
  test "return league information about given players", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({}))
    end)

    single = League.league_by_id(:lan, @sumid)
    assert {:ok, _} = single
  end

  test "return challenger league", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"entries": []}))
    end)

    queue = [:flex_sr, :flex_tt, :solo_5]

    Enum.map(queue, fn data ->
      assert {:ok, map} = League.challenger(:na, data)
      assert map["entries"] == []
    end)
  end

  test "return master league", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"entries": []}))
    end)

    queue = [:flex_sr, :solo_5]

    Enum.map(queue, fn data ->
      assert {:ok, map} = League.master(:euw, data)
      assert is_list(map["entries"])
    end)
  end
end
