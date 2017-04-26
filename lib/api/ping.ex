defmodule Sorcery.API.Ping do

  @moduledoc false

  alias Sorcery.Helpers.Response

  def request do
    Response.endmark("PONG", "PING")
  end
end
