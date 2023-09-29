defmodule Galeria.Config do
  @theme_configs [
    [
      name: "base",
      nomenclator: BuenaVista.Template.DefaultNomenclator,
      hydrator: [
        parent: BuenaVista.Template.EmptyHydrator,
        base_module_name: Galeria.Config,
        out_dir: "lib/config",
        imports: [
          BuenaVista.Constants.DefaultSizes,
          BuenaVista.Constants.DefaultColors
        ]
      ],
      css: nil
    ],
    [
      name: "light",
      nomenclator: BuenaVista.Template.DefaultNomenclator,
      hydrator: [
        parent: Galeria.Config.BaseHydrator,
        base_module_name: Galeria.Config,
        out_dir: "lib/config",
        imports: [
          BuenaVista.Constants.DefaultColors
        ]
      ],
      css: [out_dir: "lib/assets/themes"]
    ],
    [
      name: "dark",
      nomenclator: BuenaVista.Template.DefaultNomenclator,
      hydrator: [
        parent: Galeria.Config.BaseHydrator,
        base_module_name: Galeria.Config,
        out_dir: "lib/config",
        imports: [
          BuenaVista.Constants.DefaultColors
        ]
      ],
      css: [out_dir: "lib/assets/themes"]
    ]
  ]

  @default_theme_name "light"
  @themes for theme_config <- @theme_configs, do: BuenaVista.Helpers.build_theme(theme_config)

  def get_themes(), do: @themes

  def find_theme(theme_name) when is_binary(theme_name) do
    case Enum.find(get_themes(), fn theme -> theme.name == theme_name end) do
      %BuenaVista.Theme{} = theme -> {:ok, theme}
      _ -> {:error, :not_found}
    end
  end

  def get_default_theme() do
    find_theme(@default_theme_name)
  end
end
