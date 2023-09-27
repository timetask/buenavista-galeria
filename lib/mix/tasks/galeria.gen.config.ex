defmodule Mix.Tasks.Galeria.Gen.Config do
  use Mix.Task
  require Logger

  @requirements ["app.config"]

  @shortdoc "Generates galeria hydrators"
  def run(_opts) do
    apps = [:galeria]
    themes = Galeria.Config.get_themes()

    BuenaVista.Generator.generate_config_files(themes, apps)
  end
end
