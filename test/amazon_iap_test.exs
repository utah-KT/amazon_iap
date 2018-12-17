defmodule AmazonIAPTest do
  use ExUnit.Case
  alias AmazonIAP.RVSResponse
  require AmazonIAP.ErrorStatus, as: ErrorStatus
  doctest AmazonIAP

  setup_all do
    user_id = "l3HL7XppEMhrOGDnur9-ulvqomrSg6qyODKmah76lJU="
    receipt_id = "q1YqVbJSyjH28DGPKChw9c0o8nd3ySststQtzSkrzM8tCk43K6z0d_HOTcwwN8vxCrVV0lEqBmpJzs_VS8xNrMrP0ytOzC3ISdXLTCzQS87PKy7NTUwCcvOLEvPSU4GqS5SsDHSUUoB6DE3MDQyNTIzNTM0sTZRqAQ"
    json = %{
      "betaProduct": false,
      "cancelDate": nil,
      "parentProductId": nil,
      "productId": "com.amazon.iapsamplev2.gold_medal",
      "productType": "CONSUMABLE",
      "purchaseDate": 1399070221749,
      "quantity": 1,
      "receiptId": receipt_id,
      "renewalDate": nil,
      "term": nil,
      "termSku": nil,
      "testTransaction": true
    }
    json_string = Poison.encode!(json)
    cancelled_json_string = Poison.encode!(%{json | "cancelDate": DateTime.utc_now() |> DateTime.to_unix()})
    raw_receipt = Base.encode64(json_string)
    struct = %RVSResponse{
      beta_product: false,
      cancel_date: nil,
      parent_product_id: nil,
      product_id: "com.amazon.iapsamplev2.gold_medal",
      product_type: "CONSUMABLE",
      purchase_date: 1399070221749,
      quantity: 1,
      receipt_id: receipt_id,
      renewal_date: nil,
      term: nil,
      term_sku: nil,
      test_transaction: true
    }
    %{json_string: json_string, cancelled_json_string: cancelled_json_string, struct: struct, user_id: user_id, receipt_id: receipt_id, raw_receipt: raw_receipt}
  end

  test "verify raw receipt", %{user_id: user_id, raw_receipt: raw_receipt} do
    {status, _} = AmazonIAP.verify_raw_receipt(user_id, raw_receipt)
    assert status == :ok
  end

  test "verify receipt", %{user_id: user_id, receipt_id: receipt_id} do
    {status, _} = AmazonIAP.verify_receipt(user_id, receipt_id)
    assert status == :ok
  end

  test "invalid receipt", %{user_id: user_id} do
    assert AmazonIAP.verify_receipt(user_id, "invalid") == {:error, ErrorStatus.invalid_receipt_id}
  end

  test "invalid user_id", %{receipt_id: receipt_id} do
    assert AmazonIAP.verify_receipt("invalid", receipt_id) == {:error, ErrorStatus.invalid_user_id}
  end

  test "when http request was failed" do
    assert AmazonIAP.parse_response({:error, :error}) == {:error, ErrorStatus.http_request_failed, :error}
  end

  test "parse succeeded response", %{json_string: json_string, struct: struct} do
    response = %HTTPoison.Response{status_code: 200, body: json_string}
    assert AmazonIAP.parse_response({:ok, response}) == {:ok, struct}
  end

  test "parse cancelled response", %{cancelled_json_string: cancelled_json_string} do
    response = %HTTPoison.Response{status_code: 200, body: cancelled_json_string}
    assert AmazonIAP.parse_response({:ok, response}) == {:error, ErrorStatus.invalid_receipt, :cancelled}
  end

  test "parse failed response" do
    response = %HTTPoison.Response{status_code: 400}
    assert AmazonIAP.parse_response({:ok, response}) == {:error, 400}
  end
end
