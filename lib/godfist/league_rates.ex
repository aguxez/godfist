defmodule Godfist.LeagueRates do
  @moduledoc false

  # Handles checking the information passed and assigning the correct
  # limit to the request.

  use GenServer

  alias Godfist.HTTP

  # Rates for different servers.
  @rates [
    # "League" endpoints/servers
    euw: {300, 60_000},
    na: {270, 60_000},
    eune: {135, 60_000},
    br: {90, 60_000},
    kr: {90, 60_000},
    lan: {80, 60_000},
    las: {80, 60_000},
    tr: {60, 60_000},
    oce: {55, 60_000},
    jp: {35, 60_000},
    ru: {35, 60_000},
    # other endpoints
    match: {500, 10_000},
    matchlist: {1000, 10_000},
    champion_masteries_runes: {400, 60_000},
    static: {10, 3_600_000},
    other: {20_000, 10_000}
  ]

  # API
  def start_link, do: GenServer.start_link(__MODULE__, %{}, name: :league_limit)

  def handle_rate(region, rest, endpoint \\ nil) do
    GenServer.call(:league_limit, {:handle_rate, region, rest, endpoint}, :infinity)
  end

  # Server
  def init(state), do: {:ok, state}

  # This first handler is matching on the "Leagues" endpoints,
  # that's why endpoint is nil, that arg is meant to be used with
  # the other endpoints (Matches, Runes, etc...)
  def handle_call({:handle_rate, region, rest, endpoint}, _from, state)
      when is_nil(endpoint) do
    {amount, time} = Keyword.get(@rates, region)

    {:reply, HTTP.get(region, rest, time: time, amount: amount), state}
  end

  def handle_call({:handle_rate, region, rest, endpoint}, _from, state) do
    {amount, time} = Keyword.get(@rates, endpoint)

    {:reply, HTTP.get(region, rest, time: time, amount: amount), state}
  end
end
