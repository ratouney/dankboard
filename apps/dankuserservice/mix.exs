defmodule DankUserService.Mixfile do
  use Mix.Project

  def project do
    [app: :dankuserservice,
     version: "0.1.2",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     package: package,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [ :logger,
                           :ecto,
                           :postgrex,
                           :comeonin
                         ],
     mod: {DankUserService.Application, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # To depend on another app inside the umbrella:
  #
  #   {:my_app, in_umbrella: true}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ecto, "~> 2.1"},
      {:postgrex, ">= 0.0.0"},
      {:comeonin, "~> 2.5"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:faker, ">= 0.0.0"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    """
    The Dankest User Service there is, boi. If you want siek features, then you'll get ANOTHER one.
    """
  end

  defp package do
    # These are the default files included in the package
    [
      name: :dankuserservice,
      files: ["lib", "priv", "mix.exs", "README*"],
      description: "Yolo",
      maintainers: ["Jean Pignouf", "God"],
      licenses: ["Apache 4.20"],
      links: %{"GitHub" => "https://github.com/ratouney/dankboard"}
    ]
  end
end
