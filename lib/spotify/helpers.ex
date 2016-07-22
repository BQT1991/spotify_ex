defmodule Helpers do
  def query_string([]), do: ""
  def query_string(params), do: "?" <> URI.encode_query(params)
end
