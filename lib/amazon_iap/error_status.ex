defmodule AmazonIAP.ErrorStatus do
  @moduledoc """
  Error statuses.
  """

  @doc """
  Receipt id is invalid.
  """
  defmacro invalid_receipt_id, do: (quote do 400 end)
  @doc """
  Developer secrets is invalid.
  """
  defmacro invalid_secrets, do: (quote do 496 end)
  @doc """
  User id is invalid.
  """
  defmacro invalid_user_id, do: (quote do 497 end)
  @doc """
  Amazon RVS is something wrong.
  """
  defmacro internal_rvs_error, do: (quote do 500 end)
  @doc """
  HTTP request was failed.
  """
  defmacro http_request_failed, do: (quote do 1000 end)
  @doc """
  Receipt is invalid.
  """
  defmacro invalid_receipt, do: (quote do 1001 end)
end
