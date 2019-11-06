defmodule HelloWeb.UserController do
  use HelloWeb, :controller
  alias Hello.Repo
  alias Hello.User

  def index(conn, _params) do
    users = Repo.all(Hello.User)
    render conn, "index.html", users: users
  end

  def show(conn, %{"id" => uid}) do
    userfrm_db = Repo.get(User, uid)
    render(conn, "show.html", userfrm_db: userfrm_db)
  end

    def new(conn, _params) do
      myuser = %User{}
      changeset = User.changeset(myuser, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do

    changeset = User.changeset(%User{}, user_params)
    case Repo.insert(changeset) do
         {:ok, user} ->
           conn
           |> put_flash(:info, "User created successfully.")
           |> redirect(to: Routes.user_path(conn, :index))

         {:ok, error} ->
           render(conn, "new.html", changeset: changeset)
       end
  end

  def edit(conn, %{"id" => uid}) do
    userfrm_db = Repo.get(User, uid)
    changeset = User.changeset(userfrm_db, %{})
    render(conn, "edit.html", changeset: changeset, userfrm_db: userfrm_db)
  end

  def update(conn, %{"id" => uid, "user" => user_params}) do
    user = Repo.get(User, uid)
    changeset = User.changeset(user, user_params)
    case Repo.update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User update successfully.")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, _error} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end


  def delete(conn, %{"id" => uid}) do
    userfrm_db = Repo.get(User, uid)
    case Repo.delete(userfrm_db) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User deleted successfully.")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, _error} ->
        render conn, "index.html", userfrm_db: uid
    end
  end
end

