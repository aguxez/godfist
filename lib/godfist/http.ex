defmodule Godfist.HTTP do
  @moduledoc false

  @endpoint %{
    br: "https://br1.api.riotgames.com",
    eune: "https://eun1.api.riotgames.com",
    euw: "https://euw1.api.riotgames.com",
    jp: "https://jp1.api.riotgames.com",
    kr: "https://kr.api.riotgames.com",
    lan: "https://la1.api.riotgames.com",
    las: "https://la2.api.riotgames.com",
    na: "https://na1.api.riotgames.com",
    oce: "https://oc1.api.riotgames.com",
    tr: "https://tr1.api.riotgames.com",
    ru: "https://ru.api.riotgames.com",
    pbe: "https://pbe1.api.riotgames.com",
    global: "https://global.api.riotgames.com",
    dragon: "https://ddragon.leagueoflegends.com/cdn"
  }

  def get([region: region, rest: rest]) when region == :dragon do
    dragon = Map.get(@endpoint, :dragon)

    get_body(dragon <> rest)
  end
  def get([region: region, rest: rest]) do
    url = Map.get(@endpoint, region)

    region
    |> ExRated.check_rate(time, amount)
    |> parse(url, rest)
  end

  defp parse({:ok, _}, url, rest) do
    case String.contains?(rest, "?") do
      true ->
        get_body("#{url <> rest}&api_key=#{token}")
      _ ->
        get_body("#{url <> rest}?api_key=#{token}")
    end
  end
  defp parse({:error, _}, _, _) do
    Process.sleep(5000)

    {:error, "Rate limit hit, let's slow down"}
  end

  defp get_body(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, response} = Poison.decode(body)
        {:ok, response}
      {:ok, %{status_code: 404}} ->
        {:error, "Not found"}
      {:error, reason} ->
        {:error, reason}
    end
  end

  defp token do
    Application.get_env(:godfist, :token, System.get_env("RIOT_TOKEN"))
  end

  defp time do
    Application.get_env(:godfist, :time)
  end

  defp amount do
    Application.get_env(:godfist, :amount)
  end
end
