defmodule Godfist.ChampionTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Godfist.{Champion, LeagueRates}

  @champid 64

  setup do
    bypass = Bypass.open()
    LeagueRates.start_link(bypass.port)

    {:ok, bypass: bypass}
  end

  # Champion tests.
  test "returns list of all champions", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"champions": []}))
    end)

    assert {:ok, map} = Champion.all(:na)
    assert is_list(map["champions"])
  end

  test "returns single champion information", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"rankedPlayEnabled": true}))
    end)

    assert {:ok, map} = Champion.by_id(:las, @champid)
    assert map["rankedPlayEnabled"] == true
  end
end
