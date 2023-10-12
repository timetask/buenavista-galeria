defmodule Mix.Tasks.Galeria.Gen.Internal.Config do
  @moduledoc """
    **Intendend for internal use only.**

    Generates Galerias hydrators.
  """
  use Mix.Task
  require Logger

  @requirements ["app.config"]

  @shortdoc "Generates galeria hydrators"
  def run(opts) do
    {parsed_opts, _, _} = OptionParser.parse(opts, strict: [theme: :keep])

    themes = Galeria.GaleriaConfig.get_themes() |> filter_by_name(parsed_opts)

    BuenaVista.Generator.generate_theme_files(themes)
  end

  defp filter_by_name(themes, parsed_opts) do
    theme_names = Keyword.get_values(parsed_opts, :theme)

    if Enum.empty?(theme_names),
      do: themes,
      else: Enum.filter(themes, fn theme -> theme.name in theme_names end)
  end
end
