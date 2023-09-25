import Config

config :buenavista,
  apps: [:galeria],
  themes: [
    [
      name: "base",
      nomenclator: BuenaVista.Template.DefaultNomenclator,
      hydrator: [
        parent: BuenaVista.Template.EmptyHydrator,
        base_module_name: Galeria.Config,
        out_dir: "lib/config",
        imports: [
          # BuenaVista.Constants.DefaultColors,
          # BuenaVista.Constants.DefaultSizes
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
          # BuenaVista.Constants.DefaultColors,
          # BuenaVista.Constants.DefaultSizes
        ]
      ],
      css: [out_dir: "priv/static/themes"]
    ],
    [
      name: "dark",
      nomenclator: BuenaVista.Template.DefaultNomenclator,
      hydrator: [
        parent: Galeria.Config.BaseHydrator,
        base_module_name: Galeria.Config,
        out_dir: "lib/config",
        imports: [
          # BuenaVista.Constants.DefaultColors,
          # BuenaVista.Constants.DefaultSizes
        ]
      ],
      css: [out_dir: "priv/static/themes"]
    ]
  ]
