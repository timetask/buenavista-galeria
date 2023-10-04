[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  plugins: [Phoenix.LiveView.HTMLFormatter, BuenaVista.CssFormatter],
  import_deps: [:phoenix, :buenavista]
]
