defmodule ZashiHRWeb.Graphql.Types do
  use Absinthe.Schema.Notation

  import_types Absinthe.Type.Custom
  import_types(ZashiHRWeb.Graphql.Types.{
    Sessions, Users, AdminUsers, Resumes, UserAddress, UserContact, UserEducation, AppSettings
  })

  @desc "query filter operators"
  input_object :filter_operators, description: "filter operators" do
    field :contains, :string
    field :eq, :string
    field :gte, :string
    field :lte, :string
    field :gt, :string
    field :lt, :string
  end

  input_object :order_by_operators, description: "sort operators" do
    field :order, :order_types
  end

  input_object :pagination_input, description: "pagination inputs" do
    field :page, non_null(:integer)
    field :size, non_null(:integer)
  end

  # TYPES
  @desc "job types"
  enum :job_types do
    value :fulltime, as: "FULLTIME"
    value :parttime, as: "PARTTIME"
    value :intern, as: "INTERN"
  end

  @desc "salary frequancy"
  enum :salary_frequency do
    value :monthly, as: "monthly"
    value :yearly, as: "yearly"
  end

  @desc "job types"
  enum :order_types do
    value :asc, as: "ASC"
    value :desc, as: "DESC"
  end
end
