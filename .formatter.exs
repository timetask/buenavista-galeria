locals_without_parens = [
  galeria: 2,
  galeria: 1
]

[
  inputs: ["{mix,.formatter}.exs", "{config,lib,test}/**/*.{ex,exs}"],
  plugins: [BuenaVista.CssFormatter],
  import_deps: [:phoenix, :buenavista],
  locals_without_parens: locals_without_parens,
  export: [locals_without_parens: locals_without_parens]
]
