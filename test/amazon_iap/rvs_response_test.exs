defmodule AmazonIAP.RVSResponseTest do
  use ExUnit.Case
  alias AmazonIAP.RVSResponse
  doctest AmazonIAP.RVSResponse

  setup_all do
    json = %{
      "betaProduct": false,
      "cancelDate": nil,
      "parentProductId": nil,
      "productId": "com.amazon.iapsamplev2.gold_medal",
      "productType": "CONSUMABLE",
      "purchaseDate": 1399070221749,
      "quantity": 1,
      "receiptId": "wE1EG1gsEZI9q9UnI5YoZ2OxeoVKPdR5bvPMqyKQq5Y=:1:11",
      "renewalDate": nil,
      "term": nil,
      "termSku": nil,
      "testTransaction": true
    }
    json_string = Poison.encode!(json)
    struct = %RVSResponse{
      beta_product: false,
      cancel_date: nil,
      parent_product_id: nil,
      product_id: "com.amazon.iapsamplev2.gold_medal",
      product_type: "CONSUMABLE",
      purchase_date: 1399070221749,
      quantity: 1,
      receipt_id: "wE1EG1gsEZI9q9UnI5YoZ2OxeoVKPdR5bvPMqyKQq5Y=:1:11",
      renewal_date: nil,
      term: nil,
      term_sku: nil,
      test_transaction: true
    }
    %{json: json, json_string: json_string, struct: struct}
  end

  test "to_struct/1 converts a json into RVSResponse", %{json: json, struct: struct} do
    assert RVSResponse.to_struct(json) == struct
  end

  test "from_json/1 converts a json into RVSResponse", %{json_string: json_string, struct: struct} do
    assert RVSResponse.from_json(json_string) == struct
  end
end
