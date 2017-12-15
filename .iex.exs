#{:ok, server_pid} = Sorcery.Server.start_link()
Code.require_file("stubs.exs", "apps/sorcery/test")