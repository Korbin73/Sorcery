defmodule Stubs do
  def initial_request do
    %{
      processId: 2885,
      rootPath: "/Users/Lee1/Documents/garden_api",
      rootUri: "file:///Users/Lee1/Documents/garden_api",
      capabilities: %{
          workspace: %{
            applyEdit: true,
            workspaceEdit: %{
              documentChanges: true
            },
            didChangeConfiguration: %{
              dynamicRegistration: false
            },
            didChangeWatchedFiles: %{
              dynamicRegistration: true
            },
            symbol: %{
              dynamicRegistration: true
            },
            executeCommand: %{
              dynamicRegistration: true
            }
          },
          textDocument: %{
              synchronization: %{
                dynamicRegistration: true,
                willSave: true,
                willSaveWaitUntil: true,
                didSave: true
              },
              completion: %{
                dynamicRegistration: true,
                completionItem: %{
                    snippetSupport: true
                }
              },
              hover: %{
                dynamicRegistration: true
              },
              signatureHelp: %{
                dynamicRegistration: true
              },
              references: %{
                dynamicRegistration: true
              },
              documentHighlight: %{
                dynamicRegistration: true
              },
              documentSymbol: %{
                dynamicRegistration: true
              },
              formatting: %{
                dynamicRegistration: true
              },
              rangeFormatting: %{
                dynamicRegistration: true
              },
              onTypeFormatting: %{
                dynamicRegistration: true
              },
              definition: %{
                dynamicRegistration: true
              },
              codeAction: %{
                dynamicRegistration: true
              },
              codeLens: %{
                dynamicRegistration: true
              },
              documentLink: %{
                dynamicRegistration: true
              },
              rename: %{
                dynamicRegistration: true
              }
          }
      },
      trace: "verbose"
  }
  end

  def header_request do
    "Content-Length: 1272\r\n\r\n"
  end

  def raw_initial_request do
    "{\"jsonrpc\":\"2.0\",\"id\":0,\"method\":\"initialize\",\"params\":{\"processId\":17132,\"rootPath\":\"/Users/Lee1/Documents/elixir_navigator/language_service\",\"rootUri\":\"file:///Users/Lee1/Documents/elixir_navigator/language_service\",\"capabilities\":{\"workspace\":{\"applyEdit\":true,\"didChangeConfiguration\":{\"dynamicRegistration\":true},\"didChangeWatchedFiles\":{\"dynamicRegistration\":true},\"symbol\":{\"dynamicRegistration\":true},\"executeCommand\":{\"dynamicRegistration\":true}},\"textDocument\":{\"synchronization\":{\"dynamicRegistration\":true,\"willSave\":true,\"willSaveWaitUntil\":true,\"didSave\":true},\"completion\":{\"dynamicRegistration\":true,\"completionItem\":{\"snippetSupport\":true,\"commitCharactersSupport\":true}},\"hover\":{\"dynamicRegistration\":true},\"signatureHelp\":{\"dynamicRegistration\":true},\"definition\":{\"dynamicRegistration\":true},\"references\":{\"dynamicRegistration\":true},\"documentHighlight\":{\"dynamicRegistration\":true},\"documentSymbol\":{\"dynamicRegistration\":true},\"codeAction\":{\"dynamicRegistration\":true},\"codeLens\":{\"dynamicRegistration\":true},\"formatting\":{\"dynamicRegistration\":true},\"rangeFormatting\":{\"dynamicRegistration\":true},\"onTypeFormatting\":{\"dynamicRegistration\":true},\"rename\":{\"dynamicRegistration\":true},\"documentLink\":{\"dynamicRegistration\":true}}},\"trace\":\"verbose\"}}"
  end
end