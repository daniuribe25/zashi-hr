defmodule ZashiHRWeb.PostsTest do
  use ExUnit.Case

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ZashiHR.Repo)
  end

  describe "posts queries and mutations" do

    test "get posts" do
      query = """
        query {
          posts {
            id
            title
            description
            location
            logo
            salaryBase
            salaryUpTo
            salaryFrequency
            vacants
            labels
            jobType
            insertedAt
            company {
              id
              name
              email
              phone
              description
              postCredits
              logo
            }
          }
        }
      """

      assert {:ok, %{data: data}} = Absinthe.run(query, ZashiHRWeb.Schema, context: %{})

      assert %{
        "posts" => []
      } = data
    end

  end
end
