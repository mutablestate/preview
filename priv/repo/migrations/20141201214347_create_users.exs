defmodule Preview.Repo.CreateUsers do
  use Ecto.Migration

  def up do
    create table(:users) do
      add :username, :string, size: 75
      add :password, :string, size: 125
      timestamps
    end
  end

  def down do
    drop table(:users)
  end
end
