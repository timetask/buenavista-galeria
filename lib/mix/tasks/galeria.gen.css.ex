defmodule Mix.Tasks.Galeria.Gen.Css do
  use Mix.Task
  require Logger

  @requirements ["app.config"]

  @shortdoc "Generated galeria theme css files"
  def run(_opts) do
    apps = [:galeria]
    themes = Galeria.Config.get_themes()

    BuenaVista.Generator.generate_css_files(themes, apps)
  end
end
