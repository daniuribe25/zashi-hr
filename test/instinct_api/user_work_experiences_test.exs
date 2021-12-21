defmodule ZashiHR.UserWorkExperiencesTest do
  use ZashiHR.DataCase

  alias ZashiHR.UserWorkExperiences

  describe "user_work_experiences" do
    alias ZashiHR.UserWorkExperiences.UserWorkExperience

    @valid_attrs %{active: true, company: "some company", description: "some description", from: "some from", position: "some position", to: "some to"}
    @update_attrs %{active: false, company: "some updated company", description: "some updated description", from: "some updated from", position: "some updated position", to: "some updated to"}
    @invalid_attrs %{active: nil, company: nil, description: nil, from: nil, position: nil, to: nil}

    def user_work_experience_fixture(attrs \\ %{}) do
      {:ok, user_work_experience} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserWorkExperiences.create_user_work_experience()

      user_work_experience
    end

    test "list_user_work_experiences/0 returns all user_work_experiences" do
      user_work_experience = user_work_experience_fixture()
      assert UserWorkExperiences.list_user_work_experiences() == [user_work_experience]
    end

    test "get_user_work_experience!/1 returns the user_work_experience with given id" do
      user_work_experience = user_work_experience_fixture()
      assert UserWorkExperiences.get_user_work_experience!(user_work_experience.id) == user_work_experience
    end

    test "create_user_work_experience/1 with valid data creates a user_work_experience" do
      assert {:ok, %UserWorkExperience{} = user_work_experience} = UserWorkExperiences.create_user_work_experience(@valid_attrs)
      assert user_work_experience.active == true
      assert user_work_experience.company == "some company"
      assert user_work_experience.description == "some description"
      assert user_work_experience.from == "some from"
      assert user_work_experience.position == "some position"
      assert user_work_experience.to == "some to"
    end

    test "create_user_work_experience/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserWorkExperiences.create_user_work_experience(@invalid_attrs)
    end

    test "update_user_work_experience/2 with valid data updates the user_work_experience" do
      user_work_experience = user_work_experience_fixture()
      assert {:ok, %UserWorkExperience{} = user_work_experience} = UserWorkExperiences.update_user_work_experience(user_work_experience, @update_attrs)
      assert user_work_experience.active == false
      assert user_work_experience.company == "some updated company"
      assert user_work_experience.description == "some updated description"
      assert user_work_experience.from == "some updated from"
      assert user_work_experience.position == "some updated position"
      assert user_work_experience.to == "some updated to"
    end

    test "update_user_work_experience/2 with invalid data returns error changeset" do
      user_work_experience = user_work_experience_fixture()
      assert {:error, %Ecto.Changeset{}} = UserWorkExperiences.update_user_work_experience(user_work_experience, @invalid_attrs)
      assert user_work_experience == UserWorkExperiences.get_user_work_experience!(user_work_experience.id)
    end

    test "delete_user_work_experience/1 deletes the user_work_experience" do
      user_work_experience = user_work_experience_fixture()
      assert {:ok, %UserWorkExperience{}} = UserWorkExperiences.delete_user_work_experience(user_work_experience)
      assert_raise Ecto.NoResultsError, fn -> UserWorkExperiences.get_user_work_experience!(user_work_experience.id) end
    end

    test "change_user_work_experience/1 returns a user_work_experience changeset" do
      user_work_experience = user_work_experience_fixture()
      assert %Ecto.Changeset{} = UserWorkExperiences.change_user_work_experience(user_work_experience)
    end
  end
end
