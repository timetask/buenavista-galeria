locals_without_parens = [
  galeria_routes: 2,
  galeria_routes: 1
]

[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  plugins: [Phoenix.LiveView.HTMLFormatter, BuenaVista.CssFormatter],
  import_deps: [:phoenix, :buenavista],
  locals_without_parens: locals_without_parens,
  export: [locals_without_parens: locals_without_parens]
]
