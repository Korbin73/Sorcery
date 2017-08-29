defmodule ElixirLS.LanguageServer.Client do
  def server_capabilities do
    %{"textDocumentSync" => 1,
      "hoverProvider" => false,
      "completionProvider" => %{},
      "definitionProvider" => true}
  end
end