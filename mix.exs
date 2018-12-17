defmodule AmazonIAP.Mixfile do
  use Mix.Project

  def project do
    [
      app: :amazon_iap,
      version: "0.1.1",
      elixir: "~> 1.5",
      deps: deps(),
      description: "Amazon IAP(In-App Purchasing) receipt verifier.",
      package: [
        links: %{"GitHub" => "https://github.com/utah-KT/amazon_iap"},
        licenses: ["MIT"]
      ]
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
      {:httpoison, "~> 1.2.0 or ~> 0.13.0"},
      {:poison, "~> 3.1"},
      {:dialyxir, "~> 0.5", only: :dev, runtime: false},
      {:ex_doc, "~> 0.18.0", only: :dev}
    ]
  end
end
