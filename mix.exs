defmodule Galeria.MixProject do
  use Mix.Project

  def project do
    [
      app: :buenavista_galeria,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      package: package(),
      description: description(),
      deps: deps()
    ]
  end

  defp description do
    """
    Browser based gallery and theme editor for BuenaVista component library.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Francisco Ceruti"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/timetask/buenavista-galeria"}
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_live_view, "~> 0.18"},
      {:buenavista, path: "../buenavista"},
   ]
  end
end
