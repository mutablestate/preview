# mix run seeds.ex

user = %{
         email: "my_admin_email_address",
         password: Comeonin.Bcrypt.hashpwsalt("my_admin_password")
       }

new_user = Map.merge(%Preview.User{}, user)
Preview.Repo.insert(new_user)
