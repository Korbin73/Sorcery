defmodule Sorcery.Stubs do
  import ElixirLS.LanguageServer.Server
  
  def init_server do
    %ElixirLS.LanguageServer.Server{
      build_errors: %{}, 
      build_failures: 0, 
      builder: nil, 
      changed_sources: %{}, 
      client_capabilities: %{
        "textDocument" => %{
          "codeAction" => %{
            "dynamicRegistration" => true
          }, 
          "codeLens" => %{
            "dynamicRegistration" => true
          }, 
          "completion" => %{
            "completionItem" => %{
              "snippetSupport" => true
            }, 
            "dynamicRegistration" => true
          }, 
          "definition" => %{
            "dynamicRegistration" => true
          }, 
          "documentHighlight" => %{
            "dynamicRegistration" => true
          }, 
          "documentLink" => %{
            "dynamicRegistration" => true
          }, 
          "documentSymbol" => %{
            "dynamicRegistration" => true
          }, 
          "formatting" => %{
            "dynamicRegistration" => true
          }, 
          "hover" => %{
            "dynamicRegistration" => true
          }, 
          "onTypeFormatting" => %{
            "dynamicRegistration" => true
          }, 
          "rangeFormatting" => %{
            "dynamicRegistration" => true
          }, 
          "references" => %{
            "dynamicRegistration" => true
          }, 
          "rename" => %{
            "dynamicRegistration" => true
          }, 
          "signatureHelp" => %{
            "dynamicRegistration" => true
          }, 
          "synchronization" => %{
            "didSave" => true, 
            "dynamicRegistration" => true, 
            "willSave" => true, 
            "willSaveWaitUntil" => true
          }
        }, 
        "workspace" => %{
          "applyEdit" => true, 
          "didChangeConfiguration" => %{
            "dynamicRegistration" => false
          }, 
          "didChangeWatchedFiles" => %{
            "dynamicRegistration" => false
          }, 
          "executeCommand" => %{
            "dynamicRegistration" => true
          }, 
          "symbol" => %{
            "dynamicRegistration" => true
          }, 
          "workspaceEdit" => %{
            "documentChanges" => true
          }
        }
      }, 
      currently_compiling: nil, 
      force_rebuild?: false, 
      received_shutdown?: false, 
      requests: [], 
      root_uri: "file:///home/lee/Documents/projects/Elixirist/language_server/apps/sorcery", 
      settings: nil, 
      source_files: %{}
    }
  end
end