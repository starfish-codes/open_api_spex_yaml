defmodule Mix.Tasks.Openapi.Spec.Yaml do
  @moduledoc """
  Serialize the given OpenApi spec module to a YAML file.
  ## Examples
      $ mix openapi.spec.yaml
  """
  use Mix.Task
  require Mix.Generator

  alias Mix.Tasks.Openapi.Spec.{Json, Json.Options}
  alias OpenApiSpex.OpenApi

  @default_filename "openapi.yaml"

  @impl Mix.Task
  def run(argv) do
    options = parse_options(argv)

    generate_json(options)

    options.filename
    |> load_spec_to_yaml()
    |> sanitize_spec()
    |> store_spec(options.filename)
  end

  defp generate_json(options) do
    Json.run(~w(
      --spec=#{options.spec}
      --pretty=#{options.pretty}
      #{options.filename}
    ))
  end

  defp load_spec_to_yaml(filename) do
    filename
    |> File.read!()
    |> OpenApi.json_encoder().decode!()
    |> Ymlr.document!()
  end

  defp sanitize_spec(spec) do
    spec
    |> String.split("\n")
    # vendor_extensions
    |> Enum.reject(&String.contains?(&1, ~w(operationId x-struct)))
    |> Enum.join("\n")
  end

  defp parse_options(argv) do
    parse_options = [strict: [spec: :string, endpoint: :string, pretty: :boolean]]
    {opts, args, _} = OptionParser.parse(argv, parse_options)

    %Options{
      filename: args |> List.first() || @default_filename,
      spec: Keyword.get(opts, :spec),
      pretty: Keyword.get(opts, :pretty, false)
    }
  end

  defp store_spec(spec, filename), do: File.write!(filename, spec)
end
