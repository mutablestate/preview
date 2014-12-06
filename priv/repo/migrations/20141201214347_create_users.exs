defmodule Preview.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def up do
    "CREATE TABLE users(
     id serial primary key,
     username varchar(75) unique,
     password varchar(125)
     )"
  end

  def down do
    "DROP TABLE users"
  end
end
