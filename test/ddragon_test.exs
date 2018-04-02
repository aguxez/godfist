defmodule DdragonTest do
  @moduledoc false

  use ExUnit.Case

  alias Godfist.{DataDragon, DataDragon.Data}

  @v "7.24.2"
  @endpoint "https://ddragon.leagueoflegends.com/cdn"

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

  test "return passive link" do
    link = @endpoint <> "/#{@v}/img/passive/Anivia_P.png"
    assert DataDragon.passive("Anivia") == link
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

  # Data endpoints
  test "return profile icons info" do
    assert {:ok, _} = Data.icons(:us)
  end

  test "return champions information" do
    assert {:ok, _} = Data.champions(:greek)
  end

  test "return individual champions information" do
    assert {:ok, _} = Data.single_champ("Aatrox", :french)
  end

  test "return items information" do
    assert {:ok, _} = Data.items(:spain)
  end

  test "return masteries info" do
    assert {:ok, _} = Data.masteries()
  end

  test "return runes information" do
    assert {:ok, _} = Data.runes(:japanese)
  end

  test "return summ spells" do
    assert {:ok, _} = Data.summ_spells()
  end
end
