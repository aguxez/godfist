defmodule Godfist.HTTP do
  @moduledoc false

  @token Application.get_env(:godfist, :token, System.get_env("RIOT_TOKEN"))
  @time Application.get_env(:godfist, :time)
  @amount Application.get_env(:godfist, :amount)
  @endpoint %{
    br: "br1.api.riotgames.com",
    eune: "eun1.api.riotgames.com",
    euw: "euw1.api.riotgames.com",
    jp: "jp1.api.riotgames.com",
    kr: "kr.api.riotgames.com",
    lan: "la1.api.riotgames.com",
    las: "la2.api.riotgames.com",
    na: "na1.api.riotgames.com",
    oce: "oc1.api.riotgames.com",
    tr: "tr1.api.riotgames.com",
    ru: "ru.api.riotgames.com",
    pbe: "pbe1.api.riotgames.com",
    global: "global.api.riotgames.com"
  }

  def get([region: region, rest: rest]) do
    url = Map.get(@endpoint, region)

    region
    |> ExRated.check_rate(@time, @amount)
    |> parse(url, rest)
  end

  defp parse({:ok, _}, url, rest) do
    case String.contains?(rest, "?") do
      true ->
        {:ok, get_body("https://#{url <> rest}&api_key=#{@token}")}
      _ ->
        {:ok, get_body("https://#{url <> rest}?api_key=#{@token}")}
    end
  end
  defp parse({:error, _}, _, _) do
    Process.sleep(5000)

    {:error, "Rate limit hit, let's slow down"}
  end

  defp get_body(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        Poison.decode!(body)
      {:ok, %{status_code: 404}} ->
        "Not found"
      {:error, reason} ->
        reason
    end
  end
end
