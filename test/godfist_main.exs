defmodule Godfist.Main do
  use ExUnit.Case

  test "return account id and summoner id of player" do
    {:ok, account_id} = Godfist.get_account_id(:lan, "Mjólner")
    assert 200008206 == account_id


    {:ok, summoner_id} = Godfist.get_summid(:lan, "Mjólner")
    assert 24244 == summoner_id
  end

  test "return matchlist" do
    {:ok, matches} = Godfist.matchlist(:lan, "Mjólner", champion: 64)

    assert is_map(matches) == true
  end

  # Can't test active game right now because of it would fail if there is not an
  # active match.
end
