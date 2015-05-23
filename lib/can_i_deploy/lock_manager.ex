defmodule CanIDeploy.LockManager do

# * Data managed:
#     * whether locked or not
#     * who was responsible for the lock
#     * what time the lock began
# * `lock/1` takes a name string, who initiated a lock. it will
#   not re-write lock data until lock has been released. Returns
#   the lock state
# * `lock_state/0` returns the managed state as a map with the
#   following keys:
#     * `:locked`
#     * `:locked_by` (not present when `locked? == false`)
#     * `:locked_at` (not present when `locked? == false`)
# * `locked?/0` returns a boolean, whether deploy is locked
# * `release_lock/0` resets the lock and returns the lock state

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
        locked_at: :calendar.now_to_universal_time() # replace w/ more robust `Timex` module
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
