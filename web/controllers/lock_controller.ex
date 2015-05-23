defmodule CanIDeploy.LockController do
  use CanIDeploy.Web, :controller
  alias CanIDeploy.LockManager

  plug :action

  def index(conn, _params) do
    render conn, "index.json", %{data: LockManager.lock_state}
  end

  def lock(conn, %{"text" => "lock", "user_name" => name}) do
    render conn, "index.json", %{data: LockManager.lock(name)}
  end
  def lock(conn, %{"text" => "unlock"}) do
    render conn, "index.json", %{data: LockManager.release_lock}
  end
end
