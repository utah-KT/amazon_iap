defmodule AmazonIAP.RVSResponse do
  @moduledoc """
  Struct for RVS(Receipt Verification Service) response.
  """

  defstruct [
    :beta_product, :cancel_date, :parent_product_id,
    :product_type, :purchase_date, :quantity,
    :receipt_id, :renewal_date, :term,
    :term_sku, :test_transaction, :product_id
  ]
  @type t :: %__MODULE__{
    beta_product: boolean, cancel_date: integer, parent_product_id: nil,
    product_type: binary, purchase_date: integer, quantity: integer,
    receipt_id: binary, renewal_date: integer, term: binary,
    term_sku: binary, test_transaction: boolean, product_id: binary
  }

  @spec from_json(binary) :: __MODULE__.t
  def from_json(json_string) do
    Poison.decode!(json_string)
    |> to_struct()
  end

  @spec to_struct(struct) :: __MODULE__.t
  def to_struct(json) do
    Enum.to_list(json)
    |> to_struct(%__MODULE__{})
  end
  def to_struct([{k, v}|tail], struct) do
    new_key = to_snake_case(k)
    new_struct = Map.put(struct, new_key, v)
    to_struct(tail, new_struct)
  end
  def to_struct([], struct), do: struct

  @spec to_snake_case(binary|atom) :: atom
  defp to_snake_case(k) do
    atom_to_string(k)
    |> Macro.underscore
    |> String.to_atom
  end

  @spec atom_to_string(binary|atom) :: atom
  defp atom_to_string(k) when is_atom(k), do: Atom.to_string(k)
  defp atom_to_string(k), do: k
end
