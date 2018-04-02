defmodule Godfist.SummonerTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Godfist.{Summoner, LeagueRates}

  @naid 39_626_602

  setup do
    bypass = Bypass.open()
    LeagueRates.start_link(bypass.port)

    {:ok, bypass: bypass}
  end

  # Summoner
  test "return summoner by account id", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"summonerLevel": 35}))
    end)

    assert {:ok, resp} = Summoner.by_id(:na, @naid)
    assert resp["summonerLevel"] == 35
  end

  test "return summoner by name", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id": 24244}))
    end)

    assert {:ok, resp} = Summoner.by_name(:lan, "Aguxez")
    assert resp["id"] == 24_244
  end

  test "return summoner by sumoner id", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"name": "Aguxez"}))
    end)

    # Summoner id
    assert {:ok, resp} = Summoner.by_summid(:las, 12_200_604)
    assert resp["name"] == "Aguxez"
  end

  test "return id of summoner by name", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"accountId": 123456}))
    end)

    {:ok, id} = Summoner.get_id(:las, "Laicram")
    assert is_integer(id) == true
  end
end
