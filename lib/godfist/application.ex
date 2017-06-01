defmodule Godfist.Application do
  @moduledoc false

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Cachex, [ :id_cache, [default_ttl: 86_400_000], [] ])
    ]

    Supervisor.start_link(children, strategy: :one_for_all)
  end
end
