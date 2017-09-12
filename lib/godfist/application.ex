defmodule Godfist.Application do
  @moduledoc false

  alias Godfist.LeagueRates

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Cachex, [:id_cache, [default_ttl: 86_400_000], []], id: 1),
      worker(Cachex, [:summid_cache, [default_ttl: 86_400_000], []], id: 2),
      worker(Cachex, [:champion, [default_ttl: 86_400_000], []], id: 3),
      worker(Cachex, [:all_champs, [default_ttl: 14_400_000], []], id: 4),
      worker(LeagueRates, []),
    ]

    Supervisor.start_link(children, strategy: :one_for_all)
  end
end
