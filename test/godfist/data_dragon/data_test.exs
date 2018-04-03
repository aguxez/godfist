defmodule Godfist.DataDragon.DataTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Godfist.{DataDragon.Data, LeagueRates}

  setup do
    bypass = Bypass.open()
    LeagueRates.start_link(bypass.port)

    {:ok, bypass: bypass}
  end

  # Data endpoints
  test "return profile icons info", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"type": "profileicon"}))
    end)

    assert {:ok, resp} = Data.icons(:us)
    assert resp["type"] == "profileicon"
  end

  test "return champions information", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"type": "champion"}))
    end)

    assert {:ok, resp} = Data.champions(:greek)
    assert resp["type"] == "champion"
  end

  test "return individual champions information", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"type": "champion"}))
    end)

    assert {:ok, resp} = Data.single_champ("Aatrox", :french)
    assert resp["type"] == "champion"
  end

  test "return items information", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"type": "item"}))
    end)

    assert {:ok, resp} = Data.items(:spain)
    assert resp["type"] == "item"
  end

  test "return summ spells", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"type": "summoner"}))
    end)

    assert {:ok, resp} = Data.summ_spells()
    assert resp["type"] == "summoner"
  end
end
