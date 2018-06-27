defmodule AmazonIAP.ErrorStatus do
  defmacro invalid_receipt_id, do: (quote do 400 end)
  defmacro invalid_secrets, do: (quote do 496 end)
  defmacro invalid_user_id, do: (quote do 497 end)
  defmacro internal_rvs_error, do: (quote do 500 end)
  defmacro http_request_failed, do: (quote do 1000 end)
  defmacro invalid_receipt, do: (quote do 1001 end)
end
