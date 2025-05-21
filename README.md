# Simpleicons

Based on [ex_heroicons](https://github.com/miguel-s/ex_heroicons/)

This package adds a convenient way of using [Simpleicons](https://simpleicons.org) with your Phoenix, Phoenix LiveView and Surface applications.
## Installation

Add `ex_simpleicons` and `simpleicons` to the list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_simpleicons, "~> 0.3.0"},
    {:simpleicons,
       github: "simple-icons/simple-icons",
       tag: "14.14.0",
       sparse: "icons",
       app: false,
       compile: false,
       depth: 1}
  ]
end
```

Then run `mix deps.get`.

## Usage

```elixir
<Simpleicons.icon name="github" class="simpleicon" />
```

## License

MIT. See [LICENSE](https://github.com/lorantkurthy/ex_simpleicons/blob/master/LICENSE) for more details.
