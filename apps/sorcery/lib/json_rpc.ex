defmodule Sorcery.JsonRpc do
  def notify(method, params, io_method) do
    io_method.(notification(method, params))
  end

  def notification(method, params) do 
    %{"method" => method, "params" => params, "jsonrpc" => "2.0"}
  end  

  def log_message(type, message, io_method) do
    notify("window/logMessage", %{type: message_type_code(type), message: message}, io_method)
  end

  defp send(packet), do: Sorcery.IOHandler.send(packet)

  defp message_type_code(:error), do: 1
  defp message_type_code(:warning), do: 2
  defp message_type_code(:info), do: 3
  defp message_type_code(:log), do: 4
end