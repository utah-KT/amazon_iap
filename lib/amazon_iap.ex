defmodule AmazonIAP do
  alias HTTPoison.Response
  alias AmazonIAP.RVSResponse
  require AmazonIAP.ErrorStatus, as: ErrorStatus

  @spec verify_raw_receipt(binary, binary) :: {:ok, RVSResponse.t} | {:error, integer} | {:error, integer, HTTPoison.Error.t}
  def verify_raw_receipt(user_id, receipt) do
    with {:ok, decoded} <- Base.decode64(receipt, ignore: :whitespace),
         {:ok, parsed}  <- Poison.decode(decoded),
         {:ok, receipt_id} <- Map.fetch(parsed, "receiptId")
    do
      verify_receipt(user_id, receipt_id)
    else
      _ -> {:error, ErrorStatus.invalid_receipt}
    end
  end

  @spec verify_receipt(binary, binary) :: {:ok, RVSResponse.t} | {:error, integer} | {:error, integer, HTTPoison.Error.t}
  def verify_receipt(user_id, receipt_id) do
    build_rvs_url(user_id, receipt_id)
    |> HTTPoison.get
    |> parse_response()
  end

  @spec build_rvs_url(binary, binary) :: binary
  def build_rvs_url(user_id, receipt_id) do
    config = Application.get_all_env(:amazon_iap)
    "#{config[:url_base]}/version/#{config[:version]}/verifyReceiptId/developer/config[:secrets]/user/#{user_id}/receiptId/#{receipt_id}"
  end

  @spec parse_response({:error, HTTPoison.Error.t} | {:ok, Response.t}) :: {:ok, RVSResponse.t} | {:error, integer} | {:error, integer, HTTPoison.Error.t}
  def parse_response({:error, error}), do: {:error, ErrorStatus.http_request_failed, error}
  def parse_response({:ok, %Response{status_code: 200, body: body}}) do
    {:ok, RVSResponse.from_json(body)}
  end
  def parse_response({:ok, %Response{status_code: status}}) do
    {:error, status}
  end
end
