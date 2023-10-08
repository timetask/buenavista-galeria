defmodule Galeria.Generator do
  import Mix.Generator

  @config_file Application.compile_env(:galeria, :config_path)
  @config_module Application.compile_env(:galeria, :config_module)

  def generate_project_config() do
    assigns = [config_module: @config_module]

    BuenaVista.Helpers.write_and_format_module(@config_file, config_template(assigns))
  end

  embed_template(:config, ~S/
    defmodule <%= BuenaVista.Helpers.pretty_module(@config_module) %> do

    end
  /)
end
