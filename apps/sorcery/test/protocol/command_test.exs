defmodule CommandTests do
  use ExUnit.Case, async: true
  import ElixirLS.LanguageServer.Server

  setup do
    {:ok, lang_server} = start_link() 
    {:ok, language_server: lang_server}
  end

  test "Should return server capabilities" do
    :not_implemented
  end
end