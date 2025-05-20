defmodule Simpleicons.Icon do
  @moduledoc """
  This module defines the data structure and functions for working with icons stored as SVG files.
  """

  alias __MODULE__

  @doc """
  Defines the Heroicons.Icon struct.

  Its fields are:

    * `:viewbox` - the viewbox of the icon

    * `:name` - the name of the icon

    * `:file` - the binary content of the file

  """
  defstruct [:viewbox, :name, :file]

  @type t :: %Icon{viewbox: String.t(), name: String.t(), file: binary}

  @doc "Parses a SVG file and returns structured data"
  @spec parse!(String.t()) :: Icon.t()
  def parse!(filename) do
    name =
      filename
      |> Path.split()
      |> Enum.take(-1)

    name = Path.rootname(name)

    file =
      filename
      |> File.read!()

    {viewbox, body} =
      case Regex.run(~r/<svg.*?viewBox="(.*?)".*?>(.*?)<\/svg>/, file, capture: :all_but_first) do
        [viewbox_, body_] -> {viewbox_, body_}
        _-> nil
      end
    
    %__MODULE__{viewbox: viewbox, name: name, file: body}
  end
end
