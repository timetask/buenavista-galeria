defmodule Galeria.Config do
  # ----------------------------------------
  # Data Structures
  # ----------------------------------------
  defmodule Composition do
    defstruct [:name, :template]
  end

  defmodule Default do
    defstruct [:module, :component, :opts]
  end

  # ----------------------------------------
  # Macros
  # ----------------------------------------
  defmacro composition(name, template) when is_atom(name) do
    quote bind_quoted: [name: name, template: template] do
      composition = %Composition{name: name, template: template}

      :ok = Module.put_attribute(__MODULE__, :__compositions__, composition)
    end
  end

  defmacro default(module, component, opts)
           when is_atom(module) and is_atom(component) and is_list(opts) do
    quote bind_quoted: [module: module, component: component, opts: opts] do
      default = %Default{module: module, component: component, opts: opts}

      :ok = Module.put_attribute(__MODULE__, :__defaults__, default)
    end
  end

  # ----------------------------------------
  # Persist Module Attribute
  # ----------------------------------------
  def __before_compile__(env) do
    store_compositions(env)
    store_defaults(env)
  end

  defp store_compositions(env) do
    compositions =
      for composition <- Module.get_attribute(env.module, :__compositions__) do
        {composition.name, composition}
      end

    Module.put_attribute(env.module, :compositions, compositions)
  end

  defp store_defaults(env) do
    defaults =
      for default <- Module.get_attribute(env.module, :__defaults__) do
        {{default.module, default.component}, default}
      end

    Module.put_attribute(env.module, :defaults, defaults)
  end

  # ----------------------------------------
  # Code Injection
  # ----------------------------------------
  def __using__(_opts \\ []) do
    quote do
      use Phoenix.Component

      @before_compile Galeria.Config

      Module.register_attribute(__MODULE__, :__compositions__, accumulate: true)
      Module.register_attribute(__MODULE__, :__defaults__, accumulate: true)

      Module.register_attribute(__MODULE__, :compositions, persist: true)
      Module.register_attribute(__MODULE__, :defaults, persist: true)
    end
  end
end
