defmodule Dankgate.Mixfile do
  use Mix.Project

  def project do
    [app: :dankgate,
     version: "0.0.1",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Dankgate, []},
     applications: [ :phoenix,
                     :phoenix_pubsub,
                     :cowboy,
                     :logger,
                     :gettext,
                     :absinthe,
                     :absinthe_plug,
                     :poison
                   ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [ {:phoenix, ">= 1.2.4"},
      {:phoenix_pubsub, "~> 1.0"},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:absinthe, "~> 1.3.0"},
      {:absinthe_plug, "~> 1.1"},
      {:poison, ">= 2.1.0"}
    ]
  end
end
