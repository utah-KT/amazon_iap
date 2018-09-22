# AmazonIAP

Amazon IAP receipt verifier.

## Installation

If you want to use AmazonIAP, edit your `mix.exs` file and add it as a dependency:

```elixir
def deps do
  [
    {:amazon_iap, "~> 0.1.0"}
  ]
end
```

## Usage

### Configuration

Configure these in your `config/config.exs`.


|key|value|default|
|---|---|---|
|secrets|Amazon Developer Shared secrets|---|
|url_base|URL for RVS server|http://localhost:8080/RVSSandbox|
|version|RVS operation version (see [Amazon RVS doc](https://developer.amazon.com/docs/in-app-purchasing/iap-rvs-for-android-apps.html))|1.0|

Configuration examples:
```elixir
config :amazon_iap,
  secrets: "your secrets",
  url_base: "http://localhost:8080/RVSSandbox",
  version: 1.0
```
