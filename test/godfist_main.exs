defmodule Godfist.Main do
  @moduledoc false

  use ExUnit.Case

  test "return account id and summoner id of player" do
    {:ok, account_id} = Godfist.get_account_id(:lan, "Mjólner")
    assert 200_008_206 == account_id

    {:ok, summoner_id} = Godfist.get_summid(:lan, "Mjólner")
    assert 24_244 == summoner_id
  end

  test "return matchlist" do
    {:ok, matches} = Godfist.matchlist(:lan, "Mjólner", champion: 64)

    assert is_map(matches) == true
  end

  # Can't test active game right now because of it would fail if there is not an
  # active match.

  test "champion tests" do
    {:ok, all_champs} = Godfist.all_champs(:na, ftp: true)
    {:ok, champ} = Godfist.champion(:ru, 64)
    {name, _map} = Godfist.champion_by_name("Kha'Zix")

    assert is_map(all_champs) == true
    assert is_map(champ) == true
    assert name == "Khazix"
  end

  test "return champs with similar name to the query" do
    similars =
      "Ta"
      |> Godfist.find_similar
      |> Enum.map(fn{k, _v} -> k end)

    assert similars == ["Talon", "TahmKench", "Taric", "Taliyah"]
  end
end
