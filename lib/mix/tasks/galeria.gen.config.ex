defmodule Mix.Tasks.Galeria.Gen.Config do
  use Mix.Task
  require Logger

  @requirements ["app.config"]

  @shortdoc "Generates galeria hydrators"
  def run(opts) do
    {parsed_opts, _, _} = OptionParser.parse(opts, strict: [theme: :keep])

    themes = Galeria.Config.get_themes() |> filter_by_name(parsed_opts)
    apps = [:galeria]

    BuenaVista.Generator.generate_config_files(themes, apps)
  end

  defp filter_by_name(themes, parsed_opts) do
    theme_names = Keyword.get_values(parsed_opts, :theme)

    if Enum.empty?(theme_names),
      do: themes,
      else: Enum.filter(themes, fn theme -> theme.name in theme_names end)
  end
end
