defmodule Mix.Tasks.Galeria.Gen.Config do
  use Mix.Task
  require Logger

  @requirements ["app.config"]

  @shortdoc "Generates galeria hydrators"
  def run(_opts) do
    themes = Galeria.Config.get_themes()
    BuenaVista.Generator.sync_config(themes)
  end
end
