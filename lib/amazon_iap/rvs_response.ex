defmodule AmazonIAP.RVSResponse do

  defstruct [
    :beta_product, :cancel_date, :parent_product_id,
    :product_type, :purchase_date, :quantity,
    :receipt_id, :renewal_date, :term,
    :term_sku, :test_transaction
  ]
  @type t :: %__MODULE__{
    beta_product: boolean, cancel_date: integer, parent_product_id: nil,
    product_type: binary, purchase_date: integer, quantity: integer,
    receipt_id: binary, renewal_date: integer, term: binary,
    term_sku: binary, test_transaction: boolean
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
    new_key =
      atom_to_string(k)
      |> Macro.underscore
    new_struct = Map.put(struct, new_key, v)
    to_struct(tail, new_struct)
  end
  def to_struct([], struct), do: struct

  @spec atom_to_string(binary|atom) :: binary
   defp atom_to_string(k) when is_atom(k), do: Atom.to_string(k)
  defp atom_to_string(k), do: k
end
