defmodule Galeria.Config.BaseHydrator do
  use BuenaVista.Hydrator,
    nomenclator: BuenaVista.Template.DefaultNomenclator,
    parent: BuenaVista.Template.EmptyHydrator

  # ---------------------------------------------------------------------
  # Variables
  # ---------------------------------------------------------------------

  # ---------------------------------------------------------------------
  # Galeria.Components.Layout                             sidebar_layout
  # ---------------------------------------------------------------------

  # style [:sidebar_layout, :classes, :base_class], ~CSS"""
  # """
  # style [:sidebar_layout, :classes, :sidebar_class], ~CSS"""
  # """
  # style [:sidebar_layout, :classes, :main_class], ~CSS"""
  # """
end