defmodule Godfist.StaticTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Godfist.{Static, LeagueRates}

  @champid 64

  setup do
    bypass = Bypass.open()
    LeagueRates.start_link(bypass.port)

    {:ok, bypass: bypass}
  end

  # Static
  test "returns static data of all champs", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"type": "champion"}))
    end)

    assert {:ok, resp} = Static.all_champs(:oce)
    assert resp["type"] == "champion"
  end

  test "return single champion by id", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"title": "The Blind Monk"}))
    end)

    assert {:ok, resp} = Static.champion(:oce, @champid)
    assert resp["title"] == "The Blind Monk"
  end

  test "return list of all items", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"title": "item"}))
    end)

    assert {:ok, resp} = Static.all_items(:ru)
    assert resp["title"] == "item"
  end

  test "return single item by id", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"name": "Boots of speed"}))
    end)

    assert {:ok, resp} = Static.item(:ru, 1001)
    assert resp["name"] == "Boots of speed"
  end

  test "return language strings data", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"data": {}}))
    end)

    assert {:ok, resp} = Static.lang_strings(:oce)
    assert is_map(resp["data"])
  end

  test "return supported languages", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s([]))
    end)

    assert {:ok, []} = Static.languages(:euw)
  end

  test "return map's data", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"data": {}}))
    end)

    assert {:ok, resp} = Static.maps(:eune)
    assert is_map(resp["data"])
  end

  test "return static data of masteries", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"type": "mastery"}))
    end)

    assert {:ok, resp} = Static.all_masteries(:eune)
    assert resp["type"] == "mastery"
  end

  test "return single mastery by id", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"name": "Fury"}))
    end)

    assert {:ok, body} = Static.mastery(:eune, 6111)
    assert body["name"] == "Fury"
  end

  test "return static data of profile icons", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"data": {}}))
    end)

    assert {:ok, body} = Static.profile_icons(:oce)
    assert is_map(body["data"])
  end

  test "return static data of realms", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"l": "es_MX"}))
    end)

    assert {:ok, resp} = Static.realms(:oce)
    assert resp["l"] == "es_MX"
  end

  test "returns reforged runes path", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s([{"slots": []}]))
    end)

    assert {:ok, resp} = Static.reforged_runes_path(:lan)
    assert is_list(resp)
  end

  test "returns reforged rune path by id", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s([{"slots": []}]))
    end)

    assert {:ok, resp} = Static.reforged_rune_by_id(:lan, 8200)
    assert is_list(resp)
  end

  test "returns reforged runes list", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s([{"runePathName": "Dominacion"}]))
    end)

    assert {:ok, resp} = Static.reforged_runes(:lan)
    assert hd(resp)["runePathName"] == "Dominacion"
  end

  test "returns reforged rune by id", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"name": "Cazador Ingenioso"}))
    end)

    assert {:ok, resp} = Static.reforged_rune_by_id(:lan, 8134)
    assert resp["name"] == "Cazador Ingenioso"
  end

  test "return runes data", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"type": "rune"}))
    end)

    assert {:ok, resp} = Static.all_runes(:na)
    assert resp["type"] == "rune"
  end

  test "return single rune by id", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"name": "Lesser Mark of Attack Damage"}))
    end)

    assert {:ok, resp} = Static.rune(:na, 5001)
    assert resp["name"] == "Lesser Mark of Attack Damage"
  end

  test "return summoner spells", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"type": "summoner"}))
    end)

    assert {:ok, resp} = Static.sum_spells(:na)
    assert resp["type"] == "summoner"
  end

  test "return single spell by id", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"id": 34}))
    end)

    assert {:ok, resp} = Static.spell(:oce, 34)
    assert resp["id"] == 34
  end

  test "returns tarball links", %{bypass: bypass} do
    tar = "http://ddragon.leagueoflegends.com/cdn/dragontail-8.6.1.tgz"

    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s("#{tar}"))
    end)

    assert {:ok, string} = Static.tarball_links(:ru)
    assert string == tar
  end

  test "return versions", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s([]))
    end)

    assert {:ok, []} = Static.versions(:eune)
  end
end
