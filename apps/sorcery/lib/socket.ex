defmodule Sorcery.RequestParser do
  def read_request_content(true, _), do: {:ignore, nil}
  def read_request_content(false, body) do
    {:ok, Poison.decode!(body)}
  end

  def read(raw_request) do
    String.starts_with?(raw_request, "Content")
    |> read_request_content(raw_request)
  end
end

defmodule Sorcery.Socket do
  use GenServer

  def start_link() do
    ip = Application.get_env(:tcp_server, :ip, {127,0,0,1})
    port = Application.get_env(:tcp_server, :port, 6665)
    GenServer.start_link(__MODULE__, [ip, port],[])
  end

  def init([ip, port]) do
    {:ok, listen_socket} = :gen_tcp.listen(port, [:binary,{:packet, 0},{:active,true},{:ip,ip}])
    {:ok, socket} = :gen_tcp.accept(listen_socket)
    {:ok, %{ip: ip, port: port, socket: socket}}
  end

  def handle_info({:tcp, socket, packet}, state) do
    IO.inspect(packet, label: "Incoming packet")
    #:gen_tcp.send(socket, "sending message from language socket \n")
    {:noreply, state}
  end

  def handle_info({:tcp_closed,socket},state) do
    IO.inspect "Socket has been closed"
    {:noreply,state}
  end

  def handle_info({:tcp_error,socket,reason},state) do
    IO.inspect socket,label: "connection closed dut to #{reason}"
    {:noreply,state}
  end
end