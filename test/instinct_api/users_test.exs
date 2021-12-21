defmodule ZashiHR.UsersTest do
  use ZashiHR.DataCase

  alias ZashiHR.Users

  describe "users" do
    alias ZashiHR.Users.User

    @valid_attrs %{accept_terms: true, active: true, description: "some description", email: "some email", fullname: "some fullname", logo: "some logo", password_hash: "some password_hash", phone: "some phone"}
    @update_attrs %{accept_terms: false, active: false, description: "some updated description", email: "some updated email", fullname: "some updated fullname", logo: "some updated logo", password_hash: "some updated password_hash", phone: "some updated phone"}
    @invalid_attrs %{accept_terms: nil, active: nil, description: nil, email: nil, fullname: nil, logo: nil, password_hash: nil, phone: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Users.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Users.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.accept_terms == true
      assert user.active == true
      assert user.description == "some description"
      assert user.email == "some email"
      assert user.fullname == "some fullname"
      assert user.logo == "some logo"
      assert user.password_hash == "some password_hash"
      assert user.phone == "some phone"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.accept_terms == false
      assert user.active == false
      assert user.description == "some updated description"
      assert user.email == "some updated email"
      assert user.fullname == "some updated fullname"
      assert user.logo == "some updated logo"
      assert user.password_hash == "some updated password_hash"
      assert user.phone == "some updated phone"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert user == Users.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Users.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Users.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
