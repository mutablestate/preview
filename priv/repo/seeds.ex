# mix run seeds.ex

user = %{
         email: "yoda@example.com",
         password: Comeonin.Bcrypt.hashpwsalt("usetheforce")
       }

new_user = Map.merge(%Preview.User{}, user)
Preview.Repo.insert(new_user)
