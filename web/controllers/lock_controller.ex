defmodule CanIDeploy.LockController do
  use CanIDeploy.Web, :controller
  alias CanIDeploy.LockManager

  plug :action

  def index(conn, _params) do
    render conn, "index.json", %{data: LockManager.lock_state}
  end
end
