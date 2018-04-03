defmodule Godfist.DataDragonTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Godfist.{DataDragon, LeagueRates}

  @v "7.24.2"
  @endpoint "https://ddragon.leagueoflegends.com/cdn"

  setup do
    bypass = Bypass.open()
    LeagueRates.start_link(:dragon)

    {:ok, bypass: bypass}
  end

  # Static links
  test "return profile icon img" do
    link = @endpoint <> "/#{@v}/img/profileicon/12.png"

    assert DataDragon.profile_icon(12) == link
  end

  test "return champ splash art" do
    link = @endpoint <> "/img/champion/splash/Khazix_1.jpg"

    assert DataDragon.champ_splash("Kha'Zix", 1) == link
  end

  test "return champ loading splash" do
    link = @endpoint <> "/img/champion/loading/Aatrox_2.jpg"

    assert DataDragon.champ_loading("Aatrox", 2) == link
  end

  test "return champ square splash" do
    link = @endpoint <> "/#{@v}/img/champion/LeeSin.png"

    assert DataDragon.champ_square("Lee Sin") == link
  end

  test "return ability link" do
    link = @endpoint <> "/#{@v}/img/spell/AbsoluteZero.png"

    assert DataDragon.ability("Absolute Zero") == link
  end

  test "return summoner spell link" do
    link = @endpoint <> "/#{@v}/img/spell/SummonerFlash.png"

    assert DataDragon.summ_spell("flash") == link
  end

  test "return item link by id" do
    link = @endpoint <> "/#{@v}/img/item/1001.png"

    assert DataDragon.item(1001) == link
  end

  test "return mastery link" do
    link = @endpoint <> "/#{@v}/img/mastery/6111.png"

    assert DataDragon.mastery(6111) == link
  end

  test "return rune link by its id" do
    link = @endpoint <> "/#{@v}/img/rune/8001.png"

    assert DataDragon.rune(8001) == link
  end
end
