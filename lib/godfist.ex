defmodule Godfist do
  @moduledoc """
  Godfist is a wrapper for the League of Legends ReST API written in Elixir.

  There are some endpoints that I'll be adding later which will be the static
  data from Data Dragon and Tournament support.

  Every function requires that you pass the region to execute the request to
  since Riot uses that to Rate limit the usage of the api. Every region should
  be passed as an Atom, remember that :P

  Set your api key in your `config.exs` file with the given params.

  ```elixir
  config :godfist,
  token: "YOUR API KEY",
  time: 1000, # This is the minimum default from Riot, set this time in miliseconds.
  amount: 10 # Amount of request limit, default minium is 10 each 10 seconds.
  ```
  """

  alias Godfist.{Summoner}

  @doc """
  Get the id of a player by it's region and name.

  Refer to `Godfist.Summoner.get_id/2`
  """
  def get_id(region, name) do
    with {:missing, nil} <- Cachex.get(:id_cache, "id_#{inc(name)}"),
         {:ok, id} when is_integer(id) <- Summoner.get_id(region, name) do
      Cachex.set!(:id_cache, "id_#{inc(name)}", id)
      {:ok, id}
    else
      {:ok, id} ->
        {:ok, id}
      {:error, reason} ->
        {:ok, reason}
    end
  end

  # Make everything 1 word, "inc" is short for inconsistency.
  defp inc(name) do
    String.replace(name, " ", "@")
  end
end
