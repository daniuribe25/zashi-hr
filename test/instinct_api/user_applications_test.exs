defmodule ZashiHR.UserApplicationsTest do
  use ZashiHR.DataCase

  alias ZashiHR.UserApplications

  describe "user_applications" do
    alias ZashiHR.UserApplications.UserApplication

    @valid_attrs %{active: true}
    @update_attrs %{active: false}
    @invalid_attrs %{active: nil}

    def user_application_fixture(attrs \\ %{}) do
      {:ok, user_application} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserApplications.create_user_application()

      user_application
    end

    test "list_user_applications/0 returns all user_applications" do
      user_application = user_application_fixture()
      assert UserApplications.list_user_applications() == [user_application]
    end

    test "get_user_application!/1 returns the user_application with given id" do
      user_application = user_application_fixture()
      assert UserApplications.get_user_application!(user_application.id) == user_application
    end

    test "create_user_application/1 with valid data creates a user_application" do
      assert {:ok, %UserApplication{} = user_application} = UserApplications.create_user_application(@valid_attrs)
      assert user_application.active == true
    end

    test "create_user_application/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserApplications.create_user_application(@invalid_attrs)
    end

    test "update_user_application/2 with valid data updates the user_application" do
      user_application = user_application_fixture()
      assert {:ok, %UserApplication{} = user_application} = UserApplications.update_user_application(user_application, @update_attrs)
      assert user_application.active == false
    end

    test "update_user_application/2 with invalid data returns error changeset" do
      user_application = user_application_fixture()
      assert {:error, %Ecto.Changeset{}} = UserApplications.update_user_application(user_application, @invalid_attrs)
      assert user_application == UserApplications.get_user_application!(user_application.id)
    end

    test "delete_user_application/1 deletes the user_application" do
      user_application = user_application_fixture()
      assert {:ok, %UserApplication{}} = UserApplications.delete_user_application(user_application)
      assert_raise Ecto.NoResultsError, fn -> UserApplications.get_user_application!(user_application.id) end
    end

    test "change_user_application/1 returns a user_application changeset" do
      user_application = user_application_fixture()
      assert %Ecto.Changeset{} = UserApplications.change_user_application(user_application)
    end
  end
end
