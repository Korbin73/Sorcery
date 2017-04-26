defmodule Sorcery.API.PingTest do
  use ExUnit.Case, async: true
  alias Sorcery.API.Ping

  test "ping request" do
    assert Ping.request =~ """
    PONG
    END-OF-PING
    """
  end
  
end