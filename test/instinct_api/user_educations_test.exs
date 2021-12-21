defmodule ZashiHR.UserEducationsTest do
  use ZashiHR.DataCase

  alias ZashiHR.UserEducations

  describe "user_educations" do
    alias ZashiHR.UserEducations.UserEducation

    @valid_attrs %{active: true, from: "2010-04-17T14:00:00Z", institution: "some institution", title: "some title", to: "2010-04-17T14:00:00Z"}
    @update_attrs %{active: false, from: "2011-05-18T15:01:01Z", institution: "some updated institution", title: "some updated title", to: "2011-05-18T15:01:01Z"}
    @invalid_attrs %{active: nil, from: nil, institution: nil, title: nil, to: nil}

    def user_education_fixture(attrs \\ %{}) do
      {:ok, user_education} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserEducations.create_user_education()

      user_education
    end

    test "list_user_educations/0 returns all user_educations" do
      user_education = user_education_fixture()
      assert UserEducations.list_user_educations() == [user_education]
    end

    test "get_user_education!/1 returns the user_education with given id" do
      user_education = user_education_fixture()
      assert UserEducations.get_user_education!(user_education.id) == user_education
    end

    test "create_user_education/1 with valid data creates a user_education" do
      assert {:ok, %UserEducation{} = user_education} = UserEducations.create_user_education(@valid_attrs)
      assert user_education.active == true
      assert user_education.from == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert user_education.institution == "some institution"
      assert user_education.title == "some title"
      assert user_education.to == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
    end

    test "create_user_education/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserEducations.create_user_education(@invalid_attrs)
    end

    test "update_user_education/2 with valid data updates the user_education" do
      user_education = user_education_fixture()
      assert {:ok, %UserEducation{} = user_education} = UserEducations.update_user_education(user_education, @update_attrs)
      assert user_education.active == false
      assert user_education.from == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
      assert user_education.institution == "some updated institution"
      assert user_education.title == "some updated title"
      assert user_education.to == DateTime.from_naive!(~N[2011-05-18T15:01:01Z], "Etc/UTC")
    end

    test "update_user_education/2 with invalid data returns error changeset" do
      user_education = user_education_fixture()
      assert {:error, %Ecto.Changeset{}} = UserEducations.update_user_education(user_education, @invalid_attrs)
      assert user_education == UserEducations.get_user_education!(user_education.id)
    end

    test "delete_user_education/1 deletes the user_education" do
      user_education = user_education_fixture()
      assert {:ok, %UserEducation{}} = UserEducations.delete_user_education(user_education)
      assert_raise Ecto.NoResultsError, fn -> UserEducations.get_user_education!(user_education.id) end
    end

    test "change_user_education/1 returns a user_education changeset" do
      user_education = user_education_fixture()
      assert %Ecto.Changeset{} = UserEducations.change_user_education(user_education)
    end
  end
end
