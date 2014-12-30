# mix run seeds.ex

user = %{
         username: "my_admin_email_address",
         password: Comeonin.hashpwsalt("my_admin_password")
       }

new_user = Map.merge(%Preview.User{}, user)
Preview.Repo.insert(new_user)
