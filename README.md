# Godfist [![Build Status](https://travis-ci.org/aguxez/godfist.svg?branch=master)](https://travis-ci.org/aguxez/godfist)

## Godfist is a wrapper for League of Legends' ReST API written in Elixir.

#### Don't forget to check the [documentation](https://hexdocs.pm/godfist/Godfist.html) for a complete reference to the library.

<img src="priv/godfist.png" alt="Notify" width="400" height="300" align="left" />

## Installation

First include `godfist` in your `mix.exs` and add it to your applications.

```elixir
[extra_applications: :godfist, ...]
...
{:godfist, "~> 0.5.0"}
```

You can use `{:godfist, github: "aguxez/godfist"}` for the development version.

#### Note: if a function is in the docs but not available in your package version, use Github's instead.

## Usage
Remember to set your api key on your `config.exs` with the next params.

```elixir
config :godfist,
  token: "YOUR API KEY",
  rates: :dev # or :prod
```

Or export the api key as "RIOT_TOKEN": `export RIOT_TOKEN="token"` and start making calls.

## Changes
### 0.5.0 - 03/04/18
1. Deprecated some masteries and runes functions in favor of reforged runes.
2. Removed `passive/2` from `Godfist.DataDragon`.

### 0.3.0 - 13/01/18
1. Deprecated `Godfist.League.get_all/2` for `Godfist.League.league_by_id/2`.

### 0.3.0
1. Deprecated `Godfist.League.get_entry/2` for `Godfist.League.positions/2`.
2. Rate limit options are not given to `config.exs` anymore, just `:token`.
3. Implemented a different way of handling rate limits, soon to be overridable for your own solution.
4. Removed some queues from the `Godfist.League` module.


### TODO
- [ ] Add tournament endpoints.
- [ ] Let users implement their own rate limit solutions instead of the built-in.

### Dev Todo
- [ ] Add more tests (Never ending)
