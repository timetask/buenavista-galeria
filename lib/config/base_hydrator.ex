defmodule Galeria.Config.BaseHydrator do
  use BuenaVista.Hydrator,
    nomenclator: BuenaVista.Template.DefaultNomenclator,
    parent: BuenaVista.Template.EmptyHydrator

  import BuenaVista.Constants.DefaultSizes
  import BuenaVista.Constants.DefaultColors

  # ---------------------------------------------------------------------
  # Variables
  # ---------------------------------------------------------------------

  # app
  var :app_bg, ""

  # font
  var :font_sm, ~VAR[size(3)]
  var :font_md, ~VAR[size(4)]
  var :font_lg, ~VAR[size(5)]

  # color
  var :color_title, ""
  var :color_text, ""
  var :color_border, ""
  var :color_light, ""

  # padding
  var :padding_sm, ~VAR[size(1)]
  var :padding_md, ~VAR[size(2)]
  var :padding_lg, ~VAR[size(4)]

  # success
  var :success_dark, ~VAR[color(:green, 800)]
  var :success_regular, ~VAR[color(:green, 500)]
  var :success_light, ~VAR[color(:green, 100)]

  # danger
  var :danger_dark, ~VAR[color(:green, 800)]
  var :danger_regular, ~VAR[color(:green, 500)]
  var :danger_light, ~VAR[color(:green, 100)]

  # brand
  var :brand_dark, ~VAR[color(:purple, 800)]
  var :brand_regular, ~VAR[color(:purple, 500)]
  var :brand_light, ~VAR[color(:purple, 100)]

  # sidebar
  var :sidebar_padding, ~VAR[size(4)]
  var :sidebar_width, ~VAR[size(80)]

  # main
  var :main_padding, ~VAR[size(4)]

  # ---------------------------------------------------------------------
  # Galeria.Components.Typography                          sidebar_title
  # ---------------------------------------------------------------------

  style [:sidebar_title, :classes, :base_class], ~CSS"""
    justify-content: space-between;
    align-items: center;
    display: flex;
  """

  style [:sidebar_title, :classes, :title_class], ~CSS"""
    line-height: <%= @font_lg %>;
    font-weight: 800;
    font-size: <%= @font_lg %>;
    color: <%= @color_title %>;
    text-transform: uppercase;
  """

  style [:sidebar_title, :classes, :actions_class], ~CSS"""
    gap: 0.25rem;
    align-items: center;
    display: flex;
  """

  # ---------------------------------------------------------------------
  # Galeria.Components.Layout                             sidebar_layout
  # ---------------------------------------------------------------------

  style [:sidebar_layout, :classes, :base_class], ~CSS"""
    background: <%= @app_bg %>;
    flex-wrap: wrap;
    display: flex;
  """

  style [:sidebar_layout, :classes, :sidebar_class], ~CSS"""
    background: <%= @color_light %>;
    border-right: 1px solid <%= @color_border %>;
    padding: <%= @padding_lg %>;
    min-height: 100vh;
    width: <%= @sidebar_width %>;
    flex-grow: 1;
  """

  style [:sidebar_layout, :classes, :main_class], ~CSS"""
    padding: <%= @padding_lg %>;
    flex-grow: 999;
    flex-basis: 0;
  """

  # ---------------------------------------------------------------------
  # Galeria.Components.Button                                     button
  # ---------------------------------------------------------------------

  style [:button, :classes, :base_class], ~CSS"""
    cursor: pointer;
  """

  style [:button, :size, :sm], ~CSS"""
    font-size: <%= @font_sm %>;
    border-radius: <%= @padding_sm %>;
    padding: <%= @padding_sm %>;
  """

  style [:button, :size, :md], ~CSS"""
    font-size: <%= @font_md %>;
    border-radius: <%= @padding_md %>;
    padding: <%= @padding_md %>;
  """

  style [:button, :size, :lg], ~CSS"""
    font-size: <%= @font_lg %>;
    border-radius: <%= @padding_lg %>;
    padding: <%= @padding_lg %>;
  """

  style [:button, :color, :ctrl], ~CSS"""
    border-color: <%= @color_border %>;
    color: <%= @color_text %>;
  """

  style [:button, :color, :primary], ~CSS"""
    border-color: <%= @brand_regular %>;
  """

  style [:button, :color, :success], ~CSS"""
    border-color: <%= @success_regular %>;
    color: <%= @success_dark %>;
  """

  style [:button, :color, :danger], ~CSS"""
    border-color: <%= @danger_regular %>;
    color: <%= @danger_dark %>;
  """

  style [:button, :style, :solid], ~CSS"""

    &.<%= class_name(:button, :color, :ctrl) %> {
      background: <%= @color_text %>;
      color: white;
    }

    &.<%= class_name(:button, :color, :danger) %> {
      background: <%= @danger_regular %>;
      color: white;
    }

    &.<%= class_name(:button, :color, :primary) %> {
      background: <%= @brand_regular %>;
      color: white;
    }

    &.<%= class_name(:button, :color, :success) %> {
      background: <%= @success_regular %>;
      color: white;
    }
  """

  style [:button, :style, :soft], ~CSS"""

    &.<%= class_name(:button, :color, :ctrl) %> {
      background: <%= @color_light %>;
      color: <%= @color_text %>;
    }

    &.<%= class_name(:button, :color, :danger) %> {
      background: <%= @danger_light %>;
      color: <%= @danger_regular %>;
    }

    &.<%= class_name(:button, :color, :primary) %> {
      background: <%= @brand_light %>;
      color: <%= @brand_regular %>;
    }

    &.<%= class_name(:button, :color, :success) %> {
      background: <%= @success_light %>;
      color: <%= @success_regular %>;
    }
  """

  style [:button, :style, :link], ~CSS"""
    text-decoration: underline;

    &.<%= class_name(:button, :color, :ctrl) %> {
      color: <%= @color_text %>;
    }

    &.<%= class_name(:button, :color, :danger) %> {
      color: <%= @danger_regular %>;
    }

    &.<%= class_name(:button, :color, :primary) %> {
      color: <%= @brand_regular %>;
    }

    &.<%= class_name(:button, :color, :success) %> {
      color: <%= @success_regular %>;
    }
  """

  style [:button, :style, :transparent], ~CSS"""
    background: transparent;

    &.<%= class_name(:button, :color, :ctrl) %> {
      color: <%= @color_text %>;

      &:hover {
        background: <%= @color_text %>;
      }
    }

    &.<%= class_name(:button, :color, :danger) %> {
      color: <%= @danger_regular %>;
    }

    &.<%= class_name(:button, :color, :primary) %> {
      color: <%= @brand_regular %>;
    }

    &.<%= class_name(:button, :color, :success) %> {
      color: <%= @success_regular %>;
    }
  """

  style [:button, :border, :thin], ~CSS"""
    border-style: solid;
    border-width: 1px;
  """

  style [:button, :border, :thick], ~CSS"""
    border-style: solid;
    border-width: 4px;
  """
end
