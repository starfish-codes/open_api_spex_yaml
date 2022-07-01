defmodule Mix.Tasks.Openapi.Spec.YamlTest do
  use ExUnit.Case
  doctest Mix.Tasks.Openapi.Spec.Yaml

  alias Mix.Tasks.Openapi.Spec.Yaml

  defmodule SpecModule do
    alias OpenApiSpex.{Info, OpenApi, Operation, Server}

    @behaviour OpenApi

    @impl OpenApi
    def spec do
      %OpenApi{
        info: %Info{
          title: "Test spec",
          version: "1.0"
        },
        paths: %{
          "/users" => %{
            "post" => %Operation{operationId: "UserController.index", responses: %{}},
            "put" => %Operation{operationId: "UserController.index", responses: %{}}
          }
        },
        servers: [
          %Server{url: "http://localhost:4000"}
        ]
      }
    end
  end

  test "generates openapi.yaml" do
    actual_schema_path = "openapi.yaml"

    Yaml.run(~w(--spec Mix.Tasks.Openapi.Spec.YamlTest.SpecModule #{actual_schema_path}))

    expected_schema_path = "test/support/example.yaml"

    assert parse_yaml(actual_schema_path) == parse_yaml(expected_schema_path)
  end

  defp parse_yaml(filename), do: filename |> File.read!() |> String.split("\n")
end
