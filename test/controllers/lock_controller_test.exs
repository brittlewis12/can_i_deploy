defmodule CanIDeploy.LockControllerTest do
  use CanIDeploy.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert json_response(conn, 200) == %{"locked" => false}
  end
end
