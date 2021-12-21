defmodule ZashiHR.CompaniesTest do
  use ZashiHR.DataCase

  alias ZashiHR.Companies

  describe "companies" do
    alias ZashiHR.Companies.Company

    @valid_attrs %{accept_terms: true, active: true, description: "some description", email: "some email", fullname: "some fullname", logo: "some logo", password_hash: "some password_hash", phone: "some phone", website: "some website"}
    @update_attrs %{accept_terms: false, active: false, description: "some updated description", email: "some updated email", fullname: "some updated fullname", logo: "some updated logo", password_hash: "some updated password_hash", phone: "some updated phone", website: "some updated website"}
    @invalid_attrs %{accept_terms: nil, active: nil, description: nil, email: nil, fullname: nil, logo: nil, password_hash: nil, phone: nil, website: nil}

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_company()

      company
    end

    test "list_companies/0 returns all companies" do
      company = company_fixture()
      assert Companies.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = company_fixture()
      assert Companies.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Companies.create_company(@valid_attrs)
      assert company.accept_terms == true
      assert company.active == true
      assert company.description == "some description"
      assert company.email == "some email"
      assert company.fullname == "some fullname"
      assert company.logo == "some logo"
      assert company.password_hash == "some password_hash"
      assert company.phone == "some phone"
      assert company.website == "some website"
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture()
      assert {:ok, %Company{} = company} = Companies.update_company(company, @update_attrs)
      assert company.accept_terms == false
      assert company.active == false
      assert company.description == "some updated description"
      assert company.email == "some updated email"
      assert company.fullname == "some updated fullname"
      assert company.logo == "some updated logo"
      assert company.password_hash == "some updated password_hash"
      assert company.phone == "some updated phone"
      assert company.website == "some updated website"
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_company(company, @invalid_attrs)
      assert company == Companies.get_company!(company.id)
    end

    test "delete_company/1 deletes the company" do
      company = company_fixture()
      assert {:ok, %Company{}} = Companies.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = company_fixture()
      assert %Ecto.Changeset{} = Companies.change_company(company)
    end
  end

  describe "posts" do
    alias ZashiHR.Companies.Post

    @valid_attrs %{active: true, description: "some description", job_type: "some job_type", labels: %{}, location: "some location", logo: "some logo", salary_base: 42, salary_frequency: 42, salary_up_to: 42, vacants: 42}
    @update_attrs %{active: false, description: "some updated description", job_type: "some updated job_type", labels: %{}, location: "some updated location", logo: "some updated logo", salary_base: 43, salary_frequency: 43, salary_up_to: 43, vacants: 43}
    @invalid_attrs %{active: nil, description: nil, job_type: nil, labels: nil, location: nil, logo: nil, salary_base: nil, salary_frequency: nil, salary_up_to: nil, vacants: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Companies.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Companies.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Companies.create_post(@valid_attrs)
      assert post.active == true
      assert post.description == "some description"
      assert post.job_type == "some job_type"
      assert post.labels == %{}
      assert post.location == "some location"
      assert post.logo == "some logo"
      assert post.salary_base == 42
      assert post.salary_frequency == 42
      assert post.salary_up_to == 42
      assert post.vacants == 42
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Companies.update_post(post, @update_attrs)
      assert post.active == false
      assert post.description == "some updated description"
      assert post.job_type == "some updated job_type"
      assert post.labels == %{}
      assert post.location == "some updated location"
      assert post.logo == "some updated logo"
      assert post.salary_base == 43
      assert post.salary_frequency == 43
      assert post.salary_up_to == 43
      assert post.vacants == 43
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_post(post, @invalid_attrs)
      assert post == Companies.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Companies.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Companies.change_post(post)
    end
  end
end
