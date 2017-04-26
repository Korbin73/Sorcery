defmodule App do
  def request do
    ~s(COMP { "L", "c:/Users/ELBRYANT/Documents/sorcery/language_server/lib/api/ping.ex", 0 })
  end
end

# IEx.configure colors: [enabled: true]
# IEx.configure colors: [ eval_result: [ :cyan, :bright ] ]
IO.puts IO.ANSI.red_background() <> IO.ANSI.white() <> " ❄❄❄ Elixir REPL ❄❄❄ " <> IO.ANSI.reset
Application.put_env(:elixir, :ansi_enabled, true)

IEx.configure(
 colors: [
   eval_result: [:green, :bright] ,
   eval_error: [[:red,:bright,"Bug Bug ..!!"]],
   eval_info: [:yellow, :bright ],
 ],
 inspect: [limit: :infinity])
