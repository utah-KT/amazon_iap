defmodule AmazonIAP do
  alias HTTPoison.Response

  require AmazonIAP.ErrorStatus, as: ErrorStatus

  def verify_receipt(user_id, receipt_id) do
    build_rvs_url(user_id, receipt_id)
    |> HTTPoison.get
    |> parse_response()
  end

  def build_rvs_url(user_id, receipt_id) do
    config = Application.get_all_env(:amazon_iap)
    "#{config[:url_base]}/version/#{config[:version]}/verifyReceiptId/developer/config[:secrets]/user/#{user_id}/receiptId/#{receipt_id}"
  end

  def parse_response({:error, error}), do: {:error, ErrorStatus.http_request_failed, error}
  def parse_response({:ok, %Response{status_code: 200, body: body}}) do
    Poison.decode!(body)
  end
  def parse_response({:ok, %Response{status_code: status}}) do
    {:error, status}
  end
end
