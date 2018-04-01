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

  def get(region, rest, opt \\ [])

  def get(region, rest, _opt) when region == :dragon do
    dragon = Map.get(@endpoint, :dragon)

    get_body(dragon <> rest)
  end

  def get(region, rest, opt) do
    url = Map.get(@endpoint, region)

    # To ensure limit on dev keys.
    with :dev <- rates(),
         {{:ok, _}, {:ok, _}} <- check_exrated_limits(region) do
      parse(url, rest)
    else
      :prod ->
        # Enforcing the time and amount of requests per method if
        # opts provided
        opt_time = Keyword.get(opt, :time)
        opt_amount = Keyword.get(opt, :amount)

        "#{region}_endpoint"
        |> ExRated.check_rate(opt_time, opt_amount)
        |> parse(url, rest)

      _ ->
        {:error, "Rate limit hit"}
    end
  end

  # Returns tuple to check limits on ExRated for dev keys.
  defp check_exrated_limits(region) do
    {
      ExRated.check_rate("#{region}_short", 1000, 20),
      ExRated.check_rate("#{region}_long", 120_000, 100)
    }
  end

  # this function is for :prod rates
  defp parse({:ok, _}, url, rest), do: parse(url, rest)
  defp parse({:error, _}, _, _), do: {:error, "Rate limit hit"}

  defp parse(url, rest) do
    case String.contains?(rest, "?") do
      true ->
        get_body("#{url <> rest}&api_key=#{token()}")

      _ ->
        get_body("#{url <> rest}?api_key=#{token()}")
    end
  end

  defp get_body(url) do
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} ->
        {:ok, response} = Poison.decode(body)
        {:ok, response}

      {:ok, %{status_code: 403}} ->
        {:error, "Forbidden. Check your API Key."}

      {:ok, %{status_code: 404}} ->
        {:error, "Not found"}

      {:ok, %{status_code: 415}} ->
        {:error, "Unsupported media type. Check the Content-Type header."}

      {:ok, %{status_code: 429}} ->
        {:error, "Rate limit exceeded."}

      {:error, reason} ->
        {:error, reason}
    end
  end

  defp token do
    Application.get_env(:godfist, :token, System.get_env("RIOT_TOKEN"))
  end

  # Gets the value of :rates to work appropriately for the rate limit.
  defp rates, do: Application.get_env(:godfist, :rates)
end
