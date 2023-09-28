defmodule Galeria.Config.LightHydrator do
  use BuenaVista.Hydrator,
    nomenclator: BuenaVista.Template.DefaultNomenclator,
    parent: Galeria.Config.BaseHydrator

  import BuenaVista.Constants.DefaultColors

  # ---------------------------------------------------------------------
  # Variables
  # ---------------------------------------------------------------------

  # app
  var :app_bg, ~VAR[color(:white)]

  # font
  # var :font_sm, ~VAR[size(3)]
  # var :font_md, ~VAR[size(4)]
  # var :font_lg, ~VAR[size(5)]

  # color
  var :color_title, ~VAR[color(:gray, 800)]
  var :color_text, ~VAR[color(:gray, 600)]
  var :color_border, ~VAR[color(:gray, 200)]

  # padding
  # var :padding_sm, ~VAR[size(1)]
  # var :padding_md, ~VAR[size(2)]
  # var :padding_lg, ~VAR[size(4)]

  # success
  # var :success_dark, ~VAR[color(:green, 800)]
  # var :success_regular, ~VAR[color(:green, 500)]
  # var :success_light, ~VAR[color(:green, 100)]

  # danger
  # var :danger_dark, ~VAR[color(:green, 800)]
  # var :danger_regular, ~VAR[color(:green, 500)]
  # var :danger_light, ~VAR[color(:green, 100)]

  # brand
  # var :brand_dark, ~VAR[color(:purple, 800)]
  # var :brand_regular, ~VAR[color(:purple, 500)]
  # var :brand_light, ~VAR[color(:purple, 100)]

  # sidebar
  # var :sidebar_padding, ~VAR[size(4)]
  # var :sidebar_width, ~VAR[size(80)]
  var :sidebar_bg, ~VAR[color(:gray, 50)]

  # main
  # var :main_padding, ~VAR[size(4)]

  # ---------------------------------------------------------------------
  # Galeria.Components.Typography                          sidebar_title
  # ---------------------------------------------------------------------

  # style [:sidebar_title, :classes, :base_class], ~CSS""" 
  #   justify-content: space-between;
  #   align-items: center;
  #   display: flex;
  #   """
  # style [:sidebar_title, :classes, :title_class], ~CSS""" 
  #   line-height: <%= @font_lg %>;
  #   font-weight: 800;
  #   font-size: <%= @sidebar_title_size %>;
  #   color: <%= @color_title %>;
  #   text-transform: uppercase;
  #   """
  # style [:sidebar_title, :classes, :actions_class], ~CSS""" 
  #   gap: 0.25rem;
  #   align-items: center;
  #   display: flex;
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Layout                             sidebar_layout
  # ---------------------------------------------------------------------

  # style [:sidebar_layout, :classes, :base_class], ~CSS""" 
  #   background: <%= @app_bg %>;
  #   flex-wrap: wrap;
  #   display: flex;
  #   """
  # style [:sidebar_layout, :classes, :sidebar_class], ~CSS""" 
  #   background: <%= @sidebar_bg %>;
  #   border-right: 1px solid <%= @color_border %>;
  #   padding: <%= @padding_lg %>;
  #   min-height: 100vh;
  #   width: <%= @sidebar_width %>;
  #   flex-grow: 1;
  #   """
  # style [:sidebar_layout, :classes, :main_class], ~CSS""" 
  #   padding: <%= @padding_lg %>;
  #   flex-grow: 999;
  #   flex-basis: 0;
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Button                                     button
  # ---------------------------------------------------------------------

  # style [:button, :classes, :base_class], ~CSS""" 
  #   cursor: pointer;
  #   """

  # style [:button, :size, :sm], ~CSS""" 
  #   font-size: <%= @font_sm %>;
  #   border-radius: <%= @padding_sm %>;
  #   padding: <%= @padding_sm %>;
  #   """
  # style [:button, :size, :md], ~CSS""" 
  #   font-size: <%= @font_md %>;
  #   border-radius: <%= @padding_md %>;
  #   padding: <%= @padding_md %>;
  #   """
  # style [:button, :size, :lg], ~CSS""" 
  #   font-size: <%= @font_lg %>;
  #   border-radius: <%= @padding_lg %>;
  #   padding: <%= @padding_lg %>;
  #   """

  # style [:button, :color, :ctrl], ~CSS""" 
  #   border-color: <%= @color_border %>;
  #   color: <%= @color_text %>;
  #   """
  # style [:button, :color, :primary], ~CSS""" 
  #   border-color: <%= @brand_regular %>;
  #   """
  # style [:button, :color, :success], ~CSS""" 
  #   border-color: <%= @success_regular %>;
  #   color: <%= @success_dark %>;
  #   """
  # style [:button, :color, :danger], ~CSS""" 
  #   border-color: <%= @danger_regular %>;
  #   color: <%= @danger_dark %>;
  #   """

  # style [:button, :background, :solid], ~CSS"""
  # """
  # style [:button, :background, :soft], ~CSS"""
  # """
  # style [:button, :background, :link], ~CSS"""
  # """
  # style [:button, :background, :transparent], ~CSS""" 
  #   background: transparent!;
  # 
  #   .<%= class_name(:button, :color, :danger) %> {
  #   }
  # 
  #   .<%= class_name(:button, :color, :success) %> {
  #   }
  # 
  #   .<%= class_name(:button, :color, :primary) %> {
  #   }
  # 
  #   .<%= class_name(:button, :color, :ctrl) %> {
  #   }
  #   """

  # style [:button, :border, :thin], ~CSS""" 
  #   border-style: solid;
  #   border-width: 1px;
  #   """
  # style [:button, :border, :thick], ~CSS""" 
  #   border-style: solid;
  #   border-width: 4px;
  #   """
end
