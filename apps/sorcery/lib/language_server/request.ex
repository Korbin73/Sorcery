defmodule ElixirLS.LanguageServer.Request do
  def handle_request(pattern, state) do    
    # initialize_req(_id, root_uri, client_capabilities)
  end

  def handle_request(pattern, state) do
    # request(_id, "shutdown", _params)
  end

  def handle_request(pattern, state) do
    # definition_req(_id, uri, line, character)
  end

  def handle_request(pattern, state) do
    # hover_req(_id, uri, line, character)
  end

  def handle_request(pattern, state) do
    # completion_req(_id, uri, line, character)
  end

  def handle_request(pattern, state) do
    # request(_, _, _)
  end
end