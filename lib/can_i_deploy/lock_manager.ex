defmodule CanIDeploy.LockManager do

  def start_link do
    Agent.start_link(fn -> %{locked: false} end, name: __MODULE__)
  end

  def locked? do
    Agent.get(__MODULE__, &Dict.get(&1, :locked))
  end

  def lock_state do
    Agent.get(__MODULE__, &(&1))
  end

  def lock(name), do: set_lock(name, locked?)

  defp set_lock(name, _locked = true), do: lock_state
  defp set_lock(name, _locked) do
    Agent.update(__MODULE__, fn dict ->
      Dict.merge(dict, %{
        locked: true,
        locked_by: name,
        locked_at: :calendar.now_to_universal_time()
      })
    end)
    lock_state
  end

  def release_lock do
    Agent.update(__MODULE__, fn dict ->
      Dict.take(dict, [:locked]) |> Dict.put(:locked, false)
    end)
    lock_state
  end

end
