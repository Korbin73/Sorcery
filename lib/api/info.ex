defmodule Sorcery.API.Info do

  @moduledoc false

  import IEx.Helpers, warn: false

  alias Sorcery.Helpers.ModuleInfo
  alias Sorcery.Helpers.Complete
  alias Sorcery.Helpers.CaptureIO
  alias Sorcery.Helpers.Response

  def request(args) do
    args
    |> normalize
    |> process
    |> Response.endmark("INFO")
  end

  def process(:modules) do
    modules = ModuleInfo.all_applications_modules
    |> Enum.uniq
    |> Enum.reject(&is_nil/1)
    |> Enum.filter(&ModuleInfo.moduledoc?/1)

    functions = Complete.run('')

    modules ++ functions
    |> Enum.uniq
    |> Enum.join("\n")
  end

  def process(:mixtasks) do
    # append things like hex or phoenix archives to the load_path
    Mix.Local.append_archives

    :code.get_path
    |> Mix.Task.load_tasks
    |> Enum.map(&Mix.Task.task_name/1)
    |> Enum.sort
    |> Enum.join("\n")
  end

  def process({:info, arg}) do
    try do
      CaptureIO.capture_io(fn ->
        Code.eval_string("i(#{arg})", [], __ENV__)
      end)
    rescue
      _e -> nil
    end
  end

  def process({:types, arg}) do
    try do
      CaptureIO.capture_io(fn ->
        Code.eval_string("t(#{arg})", [], __ENV__)
      end)
    rescue
      _e -> nil
    end
  end

  def process(nil) do
   nil
  end

  def normalize(request) do
    try do
      Code.eval_string(request)
    rescue
      _e -> nil
    else
      {{_, type }, _}     -> type
      {{_, type, arg}, _} ->
        if Version.match?(System.version, ">=1.2.0-rc") do
          {type, arg}
        else
          nil
        end
    end
  end
end
