defmodule CanIDeploy.LockViewTest do
  use CanIDeploy.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders index.json" do
    locked_map = %{locked: false}
    assert render_to_string(CanIDeploy.LockView, "index.json", [data: locked_map]) ==
           Poison.encode!(locked_map)
  end
end
