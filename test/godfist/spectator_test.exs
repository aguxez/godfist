defmodule Godfist.SpectatorTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Godfist.{Spectator, LeagueRates}

  setup do
    bypass = Bypass.open()
    LeagueRates.start_link(bypass.port)

    {:ok, bypass: bypass}
  end

  # Spectator
  test "get list of featured games", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"clientRefreshInterval": 300}))
    end)
    assert {:ok, resp} = Spectator.featured_games(:ru)
    assert resp["clientRefreshInterval"] == 300
  end
end
