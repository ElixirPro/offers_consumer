defmodule OffersConsumer.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :discount, :decimal
      add :price, :decimal

      timestamps()
    end

  end
end
