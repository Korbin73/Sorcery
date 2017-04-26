defmodule Sorcery.Integration do
  use ExUnit.Case, async: true

  test "check function or module" do
    #Sorcery.Helpers.Complete.expand(Enum.reverse(String.to_charlist("Li"))) |> IO.inspect()
  end
end
