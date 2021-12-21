defmodule ZashiHRWeb.Graphql.Types.Custom.JobType do
  use Ecto.Type

  job_types = [:fulltime, :parttime, :intern]

  def type, do: :string

  for job_type <- job_types do
    def cast(unquote(job_type)), do: {:ok, unquote(job_type)}
    def cast(unquote(to_string(job_type))), do: {:ok, unquote(job_type)}

    def load(unquote(to_string(job_type))), do: {:ok, unquote(job_type)}

    def dump(unquote(job_type)), do: {:ok, unquote(to_string(job_type))}
    def dump(unquote(to_string(job_type))), do: {:ok, unquote(to_string(job_type))}
  end

  def cast(_other), do: :error
  def dump(_other), do: :error
end
