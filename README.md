# OpenApiSpexYaml

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `open_api_spex_yaml` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:open_api_spex_yaml, "~> 3.11.0"}
  ]
end
```

## Generating the Spec

You can write the swagger file to disk using the following Mix task:

```
mix openapi.spec.yaml --spec MyAppWeb.ApiSpec
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/open_api_spex_yaml>.

