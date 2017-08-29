defmodule ElixirLS.LanguageServer.Notifications do
  import ElixirLS.LanguageServer.JsonRpc

  def handle_notification(pattern_here, state) do
    # notification("$/setTraceNotification")
  end

  def handle_notification(pattern_here, state) do
    # cancel_request(id)
  end

  def handle_notification(pattern_here, state) do
    # did_change_configuration(settings)
  end

  def handle_notification(pattern_here, state) do
    # notification("exit")
  end

  def handle_notification(pattern_here, _state) do    
    # did_open(_uri, _language_id, _version, _text)
  end
end