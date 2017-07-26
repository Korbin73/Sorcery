defmodule Sorcery.Stubs do
  def init_server do
    %{
      "params" => %{
        "trace" => "verbose",
        "rootUri" => "file:///Users/Lee1/Documents/garden_api",
        "rootPath" => "/Users/Lee1/Documents/garden_api",
        "processId" => 6369,
        "capabilities" => %{
          "workspace" => %{
            "workspaceEdit" => %{
              "documentChanges" => true
            },
            "symbol" => %{
              "dynamicRegistration" => true
            },
            "executeCommand" => %{
              "dynamicRegistration" => true
            },
            "didChangeWatchedFiles" => %{
              "dynamicRegistration" => false
            },
            "didChangeConfiguration" => %{
              "dynamicRegistration" => false
            },
            "applyEdit" => true
          },
          "textDocument" => %{
            "synchronization" => %{
              "willSaveWaitUntil" => true,
              "willSave" => true,
              "dynamicRegistration" => true,
              "didSave" => true
            },
            "signatureHelp" => %{
              "dynamicRegistration" => true
            },
            "rename" => %{
              "dynamicRegistration" => true
            },
            "references" => %{
              "dynamicRegistration" => true
            },
            "rangeFormatting" => %{
              "dynamicRegistration" => true
            },
            "onTypeFormatting" => %{
              "dynamicRegistration" => true
            },
            "hover" => %{
              "dynamicRegistration" => true
            },
            "formatting" => %{
              "dynamicRegistration" => true
            },
            "documentSymbol" => %{
              "dynamicRegistration" => true
            },
            "documentLink" => %{
              "dynamicRegistration" => true
            },
            "documentHighlight" => %{
              "dynamicRegistration" => true
            },
            "definition" => %{
              "dynamicRegistration" => true
            },
            "completion" => %{
              "dynamicRegistration" => true,
              "completionItem" => %{
                "snippetSupport" => true
              }
            },
            "codeLens" => %{
              "dynamicRegistration" => true
            },
            "codeAction" => %{
              "dynamicRegistration" => true
            }
          }
        }
      },
      "method" => "initialize",
      "jsonrpc" => "2.0",
      "id" => 0
    }
  end
end