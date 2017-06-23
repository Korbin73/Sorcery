defmodule CommandTests do
  use ExUnit.Case, async: true
  import ElixirLS.LanguageServer.Server  

  test "Should call notification" do
    # Make a call to the genserver for the initial request when the language server is started
    handle_call({:receive_packet}, :not_used, Sorcery.Stubs.init_server)
    :not_implemented
  end
end