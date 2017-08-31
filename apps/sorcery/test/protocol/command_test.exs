defmodule CommandTests do
  use ExUnit.Case, async: true
  alias ElixirLS.LanguageServer.Server  
  alias Sorcery.Stubs
  import ExUnit.CaptureIO

  require Logger

  # setup do
    # {:ok, server} = Server.start_link()
    # {:ok, process: server}
  # end

  # test "Should start genserver", %{process: pid}  do
    # result = Server.receive_packet(pid, Stubs.init_server()) 
    # assert :ok == result
  # end

  # @spec assert_capabilities({Atom.t, %{}}) :: boolean
  # def assert_capabilities({:ok, cap}) do
  #   %{ "result" => %{ "capabilities" => %{ "hoverProvider" => hover }}} = cap
  #   assert hover == false
  # end
  # def assert_capabilities({:error, _}), do: assert(false, "Didn't return capabilities")

  # @spec initial_response() :: String.t
  # def initial_response() do
  #   make_call = fn -> 
  #     Server.handle_call({:receive_packet, Stubs.init_server()}, :ignored, %ElixirLS.LanguageServer.Server{})
  #   end
  #   capture_io(make_call)
  # end

  # test "Should not return a hover provider in capabilities" do
    # response = initial_response()
    # opening_bracket = :binary.match(response,"{") |> elem(0) |> Kernel.-(2)
    # String.slice(response, opening_bracket..String.length(response)) 
    #   |> Poison.decode()
    #   |> assert_capabilities()
    
  # end
  import ElixirLS.LanguageServer.JsonRpc
  def def_macro(request(id,_,_) = packet) do
    IO.puts "request"
  end

  def def_macro(notification(_) = packet) do
    IO.puts "notification"
  end

  def get_id(%{"id" => id}) do
    IO.inspect id, label: "Parsed id"
  end

  test "check macro" do
    def_macro(Stubs.init_server())
  end

  test "Call without gen server" do
    result = Server.handle_call({:receive_packet, Stubs.init_server()}, :ignored)
    # IO.inspect(result, label: "Return from handle call")
  end
end