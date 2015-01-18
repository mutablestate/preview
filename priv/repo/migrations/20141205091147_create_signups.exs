defmodule Preview.Repo.CreateSignups do
  use Ecto.Migration

  def up do
    create table(:signups) do
      add :email, :string, size: 75
      timestamps
    end
  end

  def down do
    drop table(:signups)
  end
end
