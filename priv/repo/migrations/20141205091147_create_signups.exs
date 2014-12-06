defmodule Preview.Repo.Migrations.CreateSignups do
  use Ecto.Migration

  def up do
    "CREATE TABLE signups(
    id serial primary key,
    email varchar(75) unique
    )"
  end

  def down do
    "DROP TABLE signups"
  end
end
