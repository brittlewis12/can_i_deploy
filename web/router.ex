defmodule CanIDeploy.Router do
  use CanIDeploy.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CanIDeploy do
    pipe_through :browser # Use the default browser stack

  end
end
