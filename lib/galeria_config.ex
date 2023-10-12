defmodule Galeria.GaleriaConfig do
  @themes [
            apps: [
              [name: :buenavista_galeria]
            ],
            config: [
              base_module: Galeria.Themes,
              extend: :hydrator,
              themes_dir: "lib/themes",
              css_dir: "lib/assets/themes",
              hydrator_imports: [
                BuenaVista.Constants.TailwindColors,
                BuenaVista.Constants.TailwindSizes
              ]
            ],
            themes: [
              [name: "base", gen_css?: false],
              [name: "light", parent: "base"],
              [name: "dark", parent: "base", default?: true]
            ]
          ]
          |> BuenaVista.ConfigReader.build_themes()

  def get_themes(), do: @themes

  def find_theme(theme_name) when is_binary(theme_name) do
    case Enum.find(get_themes(), fn theme -> theme.name == theme_name end) do
      %BuenaVista.Theme{} = theme -> {:ok, theme}
      _ -> {:error, :not_found}
    end
  end

  def get_default_theme() do
    nil
  end
end
