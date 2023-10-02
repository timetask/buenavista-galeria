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
  var :app_bg_2, ""
  var :app_bg_3, ""

  # font
  var :font_sm, ~VAR[size(3)]
  var :font_md, ~VAR[size(4)]
  var :font_lg, ~VAR[size(7)]

  # weight
  var :weight_bold, "500"
  var :weight_regular, "400"
  var :weight_light, "300"

  # icon
  var :icon_sm, ~VAR[size(5)]
  var :icon_md, ~VAR[size(6)]
  var :icon_lg, ~VAR[size(7)]

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
  var :sidebar_width_collapsed, ~VAR[size(4)]

  # main
  var :main_padding, ~VAR[size(4) size(6)]

  # ---------------------------------------------------------------------
  # Galeria.Components.Typography                             page_title
  # ---------------------------------------------------------------------

  # style [:page_title, :classes, :base_class], ~CSS"""
  # """
  style [:page_title, :classes, :title_class], ~CSS"""
    font-weight: <%= @weight_bold %>;
    font-size: <%= @font_lg %>;
    color: <%= @color_title %>;
    margin: 0;
    display: inline-flex;
  """

  style [:page_title, :classes, :subtitle_class], ~CSS"""
    font-weight: <%= @weight_light %>;
    color: <%= @color_light %>;
    display: inline-flex;
  """

  # style [:page_title, :classes, :actions_class], ~CSS"""
  # """

  # ---------------------------------------------------------------------
  # Galeria.Components.Typography                       sidebar_subtitle
  # ---------------------------------------------------------------------

  style [:sidebar_subtitle, :classes, :base_class], ~CSS"""
    justify-content: space-between;
    align-items: center;
    display: flex;
  """

  style [:sidebar_subtitle, :classes, :subtitle_class], ~CSS"""
    font-weight: <%= @weight_light %>;
    font-size: <%= @font_md %>;
    color: <%= @color_light %>;
    text-transform: uppercase;
    letter-spacing: 2px;
    margin: 0;
  """

  style [:sidebar_subtitle, :classes, :actions_class], ~CSS"""
    gap: <%= @padding_sm %>;
    align-items: center;
    display: flex;
  """

  # ---------------------------------------------------------------------
  # Galeria.Components.Typography                          sidebar_title
  # ---------------------------------------------------------------------

  style [:sidebar_title, :classes, :base_class], ~CSS"""
    margin-bottom: <%= @padding_lg %>;
    justify-content: space-between;
    align-items: center;
    display: flex;
  """

  style [:sidebar_title, :classes, :title_class], ~CSS"""
    font-weight: 800;
    font-size: <%= @font_lg %>;
    color: <%= @color_title %>;
    text-transform: uppercase;
    letter-spacing: 2px;
    border: 2px solid <%= @color_title %>;
    
    padding: <%= @padding_sm %> <%= @padding_md %>;
    text-align: center;
    margin: 0;
    box-shadow: <%= @app_bg_2 %> 4px 4px 0 -2px, <%= @color_title %> 4px 4px;
  """

  style [:sidebar_title, :classes, :subtitle_class], ~CSS"""
    font-weight: <%= @weight_regular %>;
    font-size: <%= @font_md %>;
    letter-spacing: 4px;
    text-align: center;
    display: block;
  """

  style [:sidebar_title, :classes, :actions_class], ~CSS"""
    gap: <%= @padding_sm %>;
    align-items: center;
    display: flex;
  """

  # ---------------------------------------------------------------------
  # Galeria.Components.Nav                                      nav_list
  # ---------------------------------------------------------------------

  style [:nav_list, :classes, :base_class], ~CSS"""
    display: flex;
  """

  style [:nav_list, :classes, :item_class], ~CSS"""
    font-size: <%= @font_md %>;
    border-radius: <%= @padding_md %>;
    color: <%= @color_text %>;
    text-decoration: none;
    padding: <%= @padding_md %> <%= @padding_lg %>;

    &:hover {
      background: <%= @app_bg_3 %>;
    }
  """

  style [:nav_list, :classes, :item_selected_class], ~CSS"""
    background: <%= @app_bg_3 %>;
  """

  style [:nav_list, :direction, :vertical], ~CSS"""
    gap: <%= @padding_sm %>;
    width: 100%;
    flex-direction: column;
  """

  style [:nav_list, :direction, :horizontal], ~CSS"""
    gap: <%= @padding_sm %>;
    flex-direction: row;

    .<%= class_name(:nav_list, :classes, :item_class) %> {
      width: 100%;
    }
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
    gap: <%= @padding_lg %>;
    background: <%= @app_bg_2 %>;
    border-right: 1px solid <%= @color_border %>;
    padding: <%= @padding_lg %>;
    min-height: 100vh;
    flex-grow: 1;
    flex-direction: column;
    display: flex;
  """

  style [:sidebar_layout, :classes, :main_class], ~CSS"""
    padding: <%= @main_padding %>;
    flex-grow: 999;
    flex-basis: 0;
  """

  style [:sidebar_layout, :status, :open], ~CSS"""

    .<%= class_name(:sidebar_layout, :classes, :sidebar_class) %> {
      width: <%= @sidebar_width %>;
    }
  """

  style [:sidebar_layout, :status, :closed], ~CSS"""

    &:hover {

      .<%= class_name(:sidebar_layout, :classes, :sidebar_class) %> {
        background: <%= @color_border %>;
      }
    }

    .<%= class_name(:sidebar_layout, :classes, :sidebar_class) %> {
      cursor: pointer;
      padding: 0;
      width: <%= @sidebar_width_collapsed %>;
      width: <%= @sidebar_width_collapsed %>;

      * {
        display: none;
      }
    }
  """

  # ---------------------------------------------------------------------
  # Galeria.Components.Button                                     button
  # ---------------------------------------------------------------------

  style [:button, :classes, :base_class], ~CSS"""
    line-height: 1;
    border: none;
    cursor: pointer;

    &:hover {

      .<%= class_name(:button, :classes, :icon_class) %> {
        fill: <%= @app_bg %>;
      }
    }
  """

  style [:button, :classes, :icon_class], ~CSS"""
    aspect-ratio: 1 / 1;

    .<%= class_name(:button, :size, :sm) %> & {
      height: <%= @icon_sm %>;
    }

    .<%= class_name(:button, :size, :md) %> & {
      height: <%= @icon_md %>;
    }

    .<%= class_name(:button, :size, :lg) %> & {
      height: <%= @icon_lg %>;
    }
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

    &.<%= class_name(:button, :color, :success) %> {
      background: <%= @success_regular %>;
      color: white;
    }

    &.<%= class_name(:button, :color, :primary) %> {
      background: <%= @brand_regular %>;
      color: white;
    }

    &.<%= class_name(:button, :color, :danger) %> {
      background: <%= @danger_regular %>;
      color: white;
    }

    &.<%= class_name(:button, :color, :ctrl) %> {
      background: <%= @color_text %>;
      color: white;
    }
  """

  style [:button, :style, :soft], ~CSS"""

    &.<%= class_name(:button, :color, :success) %> {
      background: <%= @success_light %>;
      color: <%= @success_regular %>;
    }

    &.<%= class_name(:button, :color, :primary) %> {
      background: <%= @brand_light %>;
      color: <%= @brand_regular %>;
    }

    &.<%= class_name(:button, :color, :danger) %> {
      background: <%= @danger_light %>;
      color: <%= @danger_regular %>;
    }

    &.<%= class_name(:button, :color, :ctrl) %> {
      background: <%= @app_bg_2 %>;
      color: <%= @color_text %>;
    }
  """

  style [:button, :style, :link], ~CSS"""
    text-decoration: underline;

    &.<%= class_name(:button, :color, :success) %> {
      color: <%= @success_regular %>;
    }

    &.<%= class_name(:button, :color, :primary) %> {
      color: <%= @brand_regular %>;
    }

    &.<%= class_name(:button, :color, :danger) %> {
      color: <%= @danger_regular %>;
    }

    &.<%= class_name(:button, :color, :ctrl) %> {
      color: <%= @color_text %>;
    }
  """

  style [:button, :style, :transparent], ~CSS"""
    background: transparent;

    &.<%= class_name(:button, :color, :success) %> {
      color: <%= @success_regular %>;
    }

    &.<%= class_name(:button, :color, :primary) %> {
      color: <%= @brand_regular %>;

      &:hover {
        background: <%= @brand_regular %>;

        .<%= class_name(:button, :classes, :icon_class) %> {
          fill: white;
        }
      }

      .<%= class_name(:button, :classes, :icon_class) %> {
        fill: <%= @brand_regular %>;
      }
    }

    &.<%= class_name(:button, :color, :danger) %> {
      color: <%= @danger_regular %>;
    }

    &.<%= class_name(:button, :color, :ctrl) %> {
      color: <%= @color_text %>;

      &:hover {
        background: <%= @color_text %>;

        .<%= class_name(:button, :classes, :icon_class) %> {
          fill: <%= @app_bg %>;
        }
      }

      .<%= class_name(:button, :classes, :icon_class) %> {
        fill: <%= @color_light %>;
      }
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

  # ---------------------------------------------------------------------
  # Galeria.Components.Box                               collapsible_box
  # ---------------------------------------------------------------------

  style [:collapsible_box, :classes, :base_class], ~CSS"""
    gap: <%= @padding_md %>;
    width: 100%;
    flex-direction: column;
    display: flex;
  """

  style [:collapsible_box, :classes, :header_class], ~CSS"""
  """

  style [:collapsible_box, :classes, :content_class], ~CSS"""
  """

  # style [:collapsible_box, :status, :open], ~CSS"""
  # """
  style [:collapsible_box, :status, :closed], ~CSS"""

    .<%= class_name(:collapsible_box, :classes, :content_class) %> {
      display: none;
    }
  """
end
