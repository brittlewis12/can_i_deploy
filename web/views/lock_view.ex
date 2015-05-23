defmodule CanIDeploy.LockView do
  use CanIDeploy.Web, :view

  def render("index.json", assigns = %{data: data}) do
    data
    |> format_date
  end

  defp format_date(data = %{locked_at: date}) do
    {{year, month, day}, {hour, minute, second}} = date
    date_string =
      "#{year}-~2.10.0B-~2.10.0BT~2.10.0B:~2.10.0B:~2.10.0B-00:00"
      |> String.to_char_list
      |> :io_lib.format([month, day, hour, minute, second])
      |> List.to_string

    Dict.merge(data, %{
      locked_at: date_string
    })
  end
  defp format_date(data), do: data
end
