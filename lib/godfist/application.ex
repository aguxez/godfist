defmodule Godfist.Application do
  @moduledoc false

  import Cachex.Spec
  import Supervisor.Spec

  alias Godfist.LeagueRates

  def start(_type, _args) do
    workers =
      case Application.get_env(:godfist, :rates) do
        :test -> workers()
        _ -> workers() ++ [worker(LeagueRates, [])]
      end

    Supervisor.start_link(workers, strategy: :one_for_all)
  end

  # Checks if LeagueRates should be started automatically or not
  # based on env.
  defp workers do
    [
      worker(Cachex, [:id_cache, [expiration: expiration(default: 86_400_000)]], id: 1),
      worker(Cachex, [:summid_cache, [expiration: expiration(default: 86_400_000)]], id: 2),
      worker(Cachex, [:champion, [expiration: expiration(default: 86_400_000)]], id: 3),
      worker(Cachex, [:all_champs, [expiration: expiration(default: 14_400_000)]], id: 4),
      worker(Cachex, [:static_champs, [expiration: expiration(default: 86_400_000)]], id: 5)
    ]
  end
end
