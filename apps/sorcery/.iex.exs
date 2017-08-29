defmodule App do
  def should_find() do
    IO.puts "This is just a test"
  end
end

IEx.configure(
  colors: [
    eval_result: [:green, :bright] ,
    eval_error: [[:red,:bright,"[Error]"]],
    eval_info: [:yellow, :bright ],
  ],
  inspect: [limit: :infinity])