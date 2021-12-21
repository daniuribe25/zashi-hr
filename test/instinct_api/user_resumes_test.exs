defmodule ZashiHR.UserResumesTest do
  use ZashiHR.DataCase

  alias ZashiHR.UserResumes

  describe "user_resumes" do
    alias ZashiHR.UserResumes.UserResume

    @valid_attrs %{category: "some category", city: "some city", country: "some country", desired_job_title: "some desired_job_title", desired_salary: 42, job_type: "some job_type", photo_url: "some photo_url", resume_url: "some resume_url", summary: "some summary"}
    @update_attrs %{category: "some updated category", city: "some updated city", country: "some updated country", desired_job_title: "some updated desired_job_title", desired_salary: 43, job_type: "some updated job_type", photo_url: "some updated photo_url", resume_url: "some updated resume_url", summary: "some updated summary"}
    @invalid_attrs %{category: nil, city: nil, country: nil, desired_job_title: nil, desired_salary: nil, job_type: nil, photo_url: nil, resume_url: nil, summary: nil}

    def user_resume_fixture(attrs \\ %{}) do
      {:ok, user_resume} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserResumes.create_user_resume()

      user_resume
    end

    test "list_user_resumes/0 returns all user_resumes" do
      user_resume = user_resume_fixture()
      assert UserResumes.list_user_resumes() == [user_resume]
    end

    test "get_user_resume!/1 returns the user_resume with given id" do
      user_resume = user_resume_fixture()
      assert UserResumes.get_user_resume!(user_resume.id) == user_resume
    end

    test "create_user_resume/1 with valid data creates a user_resume" do
      assert {:ok, %UserResume{} = user_resume} = UserResumes.create_user_resume(@valid_attrs)
      assert user_resume.category == "some category"
      assert user_resume.city == "some city"
      assert user_resume.country == "some country"
      assert user_resume.desired_job_title == "some desired_job_title"
      assert user_resume.desired_salary == 42
      assert user_resume.job_type == "some job_type"
      assert user_resume.photo_url == "some photo_url"
      assert user_resume.resume_url == "some resume_url"
      assert user_resume.summary == "some summary"
    end

    test "create_user_resume/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserResumes.create_user_resume(@invalid_attrs)
    end

    test "update_user_resume/2 with valid data updates the user_resume" do
      user_resume = user_resume_fixture()
      assert {:ok, %UserResume{} = user_resume} = UserResumes.update_user_resume(user_resume, @update_attrs)
      assert user_resume.category == "some updated category"
      assert user_resume.city == "some updated city"
      assert user_resume.country == "some updated country"
      assert user_resume.desired_job_title == "some updated desired_job_title"
      assert user_resume.desired_salary == 43
      assert user_resume.job_type == "some updated job_type"
      assert user_resume.photo_url == "some updated photo_url"
      assert user_resume.resume_url == "some updated resume_url"
      assert user_resume.summary == "some updated summary"
    end

    test "update_user_resume/2 with invalid data returns error changeset" do
      user_resume = user_resume_fixture()
      assert {:error, %Ecto.Changeset{}} = UserResumes.update_user_resume(user_resume, @invalid_attrs)
      assert user_resume == UserResumes.get_user_resume!(user_resume.id)
    end

    test "delete_user_resume/1 deletes the user_resume" do
      user_resume = user_resume_fixture()
      assert {:ok, %UserResume{}} = UserResumes.delete_user_resume(user_resume)
      assert_raise Ecto.NoResultsError, fn -> UserResumes.get_user_resume!(user_resume.id) end
    end

    test "change_user_resume/1 returns a user_resume changeset" do
      user_resume = user_resume_fixture()
      assert %Ecto.Changeset{} = UserResumes.change_user_resume(user_resume)
    end
  end
end
