defmodule Simpleicons do
  @moduledoc """
  This package adds a convenient way of using [Simpleicons](https://simpleicons.org) with your Phoenix, Phoenix LiveView and Surface applications.

  ## Installation

  Add `ex_simpleicons` and `simpleicons` to the list of dependencies in `mix.exs`:

      def deps do
        [
          {:ex_simpleicons, "~> 0.2.0"},
          {:simpleicons,
            github: "simple-icons/simple-icons",
            tag: "14.14.0",
            sparse: "icons",
            app: false,
            compile: false,
            depth: 1}
        ]
      end

  Then run `mix deps.get`.

  ## Usage

      <Simpleicons.icon name="academic-cap" class="h-4 w-4" />

  ## Config

  Defaults can be set in the `Simpleicons` application configuration.

      config :ex_simpleicons
  """

  use Phoenix.Component
  alias Simpleicons.Icon

  simpleicons_path =
    if File.exists?("deps/simpleicons") do
      "deps/simpleicons"
    else
      "../simpleicons"
    end

  unless File.exists?(simpleicons_path) do
    raise """
    Simpleicons not found, please add the `Simpleicons` dependency to your project.

    Add `simpleicons` to the list of dependencies in `mix.exs`:

      def deps do
        [
          ...,
          {:simpleicons,
          github: "simple-icons/simple-icons",
          tag: "14.14.0",
          sparse: "icons",
          app: false,
          compile: false,
          depth: 1}
        ]
      end
    """
  end

  icon_paths =
    simpleicons_path
    |> Path.join("icons/*.svg")
    |> Path.wildcard()

  icons =
    for icon_path <- icon_paths do
      @external_resource Path.relative_to_cwd(icon_path)
      Icon.parse!(icon_path)
    end

  names = icons |> Enum.map(& &1.name) |> Enum.uniq()

  @names names
  def names, do: @names

  attr :name, :string, values: @names, required: true, doc: "the name of the icon"
  attr :class, :string, default: nil, doc: "the css classes to add to the svg container"
  attr :stroke_width, :string, default: "1.0", doc: "svg stroke-width"
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the svg container"

  def icon(assigns) do
    name = assigns[:name]

    if name == nil or name not in @names do
      raise ArgumentError,
            "expected icon name to be one of #{inspect(unquote(@names))}, got: #{inspect(name)}"
    end

    ~H"""
    <!-- simpleicons-<%= @name %> -->
    <.svg_container class={@class}  viewbox={svg_viewbox(@name)} stroke_width={@stroke_width} {@rest}>
      <%= {:safe, svg_body(@name)} %>
    </.svg_container>
    """
  end

  attr :class, :string, default: nil, doc: "the css classes to add to the svg container"
  attr :stroke_width, :string, default: "1.0", doc: "svg stroke-width"
  attr :rest, :global, doc: "the arbitrary HTML attributes to add to the svg container"
  attr :viewbox, :string, default: "0 0 24 24", doc: "the viewbox for the svg container"

  slot :inner_block, required: true, doc: "the svg paths to render inside the svg container"

  defp svg_container(assigns) do
    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox={@viewbox}
      stroke-width={@stroke_width}
      stroke="currentColor"
      aria-hidden="true"
      data-slot="icon"
      class={@class}
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </svg>
    """
  end

  for %Icon{name: name, viewbox: viewbox, file: file} <- icons do
    defp svg_body(unquote(name)) do
      unquote(file)
    end
    
    defp svg_viewbox(unquote(name)) do
      unquote(viewbox)
    end
  end
end
