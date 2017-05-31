# Godfist

## Godfist is a wrapper for League of Legends' ReST API written in Elixir.

### Don't forget to check the [documentation](https://hexdocs.pm/godfist/Godfist.html) for a complete reference to the library.

## Installation

First include `godfist` in your `mix.exs` and add it to your applications.

```elixir
[extra_applications: :godfist, ...]
...
{:godfist, "~> 0.1.1"}
```

## Usage
Remember to set your api key on your `config.exs` with the next params.

```elixir
config :godfist,
token: "YOUR API KEY",
time: 1000, # This is the minimum default from Riot, set this time in miliseconds.
amount: 10 # Amount of request limit, default minimum is 10 each 10 seconds.
```

Or export the api key as "RIOT_TOKEN": `export RIOT_TOKEN="token"`


### TODO: Add tournament endpoints and static data from Data Dragon.
