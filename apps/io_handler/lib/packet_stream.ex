defmodule Sorcery.IOHandler.PacketStream do
  @moduledoc """
  Reads from an IO device and provides a stream of incoming packets
  """

  def stream(pid \\ Process.group_leader) do
    if is_pid(pid), do: :io.setopts(pid, encoding: :latin1)

    Stream.resource(fn -> :ok end, fn _acc ->
      case read_packet(pid) do 
        :eof -> {:halt, :ok}
        packet -> {[packet], :ok}
      end
    end, fn _acc -> :ok end)
  end

  defp check_packet_eof(true, _, _), do: :eof
  defp check_packet_eof(false, pid, header), do: read_body(pid, header)

  defp read_packet(pid) do 
    header = read_header(pid)
    check_packet_eof(header == :eof, pid, header)    
  end

  defp read_header(pid, header \\ %{}) do
    line = IO.binread(pid, :line)
    if line == :eof do
      :eof
    else
      line = String.trim(line)
      if line == "" do
        header
      else
        [key, value] = String.split(line, ": ")
        read_header(pid, Map.put(header, key, value))
      end
    end
  end

  defp check_end_of_file(true, _), do: :eof
  defp check_end_of_file(false, body), do: Poison.decode!(body)

  defp read_body(pid, header) do 
    %{"Content-Length" => content_length_str} = header
    body = IO.binread(pid, String.to_integer(content_length_str))
    check_end_of_file(body == :eof ,body)    
  end
end