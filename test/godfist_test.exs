defmodule GodfistTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Godfist.LeagueRates

  setup do
    bypass = Bypass.open()
    LeagueRates.start_link(bypass.port)

    {:ok, bypass: bypass}
  end

  test "return champs with similar name to the query", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s<{"Zoe": {"name": "Zoe"}}>)
    end)

    similars =
      "Zo"
      |> Godfist.find_similar()
      |> Enum.map(fn {key, _v} -> key end)

    assert similars == ["Zoe"]
  end

  test "return account id of player", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s<{"accountId": 200008206}>)
    end)

    {:ok, account_id} = Godfist.get_account_id(:lan, "Aguxez")
    assert 200_008_206 == account_id
  end

  test "returns summoner_id of player", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s<{"id": 24244}>)
    end)

    {:ok, summoner_id} = Godfist.get_summid(:lan, "Aguxez")
    assert 24_244 == summoner_id
  end

  test "returns matchlist", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s<{"endIndex": 100}>)
    end)

    action = Godfist.matchlist(:lan, "Aguxez", champion: 64)

    assert {:ok, data} = action
    assert data["endIndex"] == 100
  end

  # Can't test active game right now because of it would fail if there is not an
  # active match.

  test "all_champs tests", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s<{}>)
    end)

    {:ok, all_champs} = Godfist.all_champs(:na, ftp: true)

    assert is_map(all_champs) == true
  end

  test "champion_by_name", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s<{"data": {"Talon": {"name": "Talon"}}}>)
    end)

    {name, _map} = Godfist.champion_by_name("Talon")

    assert name == "Talon"
  end

  test "champion test", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s<{"id": 64}>)
    end)

    {:ok, champ} = Godfist.champion(:ru, 64)

    assert champ["id"] == 64
  end
end
