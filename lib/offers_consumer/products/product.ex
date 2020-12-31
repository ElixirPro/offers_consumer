defmodule OffersConsumer.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :discount, :decimal
    field :name, :string
    field :price, :decimal

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :discount, :price])
    |> validate_required([:name, :discount, :price])
  end
end
