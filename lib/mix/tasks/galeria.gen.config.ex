defmodule Mix.Tasks.Galeria.Gen.Config do
  use Mix.Task

  @requirements ["app.config"]

  @shortdoc "Generates project galeria config file."
  def run(_opts) do
    Galeria.Generator.generate_project_config()
  end
end
