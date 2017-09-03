defmodule IoHandlerTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  doctest IoHandler

  defmodule Stub do
    def receive_packet(_packet) do
      {:reply, :ok, %{}}
    end
  end

  test "Should send json to stdio" do
    result = IoHandler.send(%{"movie"=>"predator"})
    assert(result == :ok, "this should fail")
  end

  test "Should return ok from process" do
    check_for_pid = fn
      {:ok, pid} -> assert(is_pid(pid), "Did not return a pid")
    end
    IoHandler.start_link(Stub)
    |> check_for_pid.()
  end 
end

