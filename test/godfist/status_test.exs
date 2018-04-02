defmodule Godfist.StatusTest do
  @moduledoc false

  use ExUnit.Case, async: true

  alias Godfist.{Status, LeagueRates}

  setup do
    bypass = Bypass.open()
    LeagueRates.start_link(bypass.port)

    {:ok, bypass: bypass}
  end

  # Status
  test "return shard data from server", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, ~s({"name": "Russia"}))
    end)

    assert {:ok, resp} = Status.shard(:ru)
    assert resp["name"] == "Russia"
  end
end
