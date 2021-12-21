defmodule ZashiHR.PostsTest do
  use ZashiHR.DataCase

  alias ZashiHR.Posts

  describe "posts" do
    alias ZashiHR.Posts.Post

    @valid_attrs %{active: true, description: "some description", job_type: "some job_type", labels: %{}, location: "some location", logo: "some logo", salary_base: 42, salary_frequency: 42, salary_up_to: 42, vacants: 42}
    @update_attrs %{active: false, description: "some updated description", job_type: "some updated job_type", labels: %{}, location: "some updated location", logo: "some updated logo", salary_base: 43, salary_frequency: 43, salary_up_to: 43, vacants: 43}
    @invalid_attrs %{active: nil, description: nil, job_type: nil, labels: nil, location: nil, logo: nil, salary_base: nil, salary_frequency: nil, salary_up_to: nil, vacants: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Posts.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Posts.create_post(@valid_attrs)
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
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Posts.update_post(post, @update_attrs)
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
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
