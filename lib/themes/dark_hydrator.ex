defmodule Galeria.Themes.DarkHydrator do
  use BuenaVista.Hydrator,
    nomenclator: BuenaVista.Themes.DefaultNomenclator,
    parent: Galeria.Themes.BaseHydrator

  import BuenaVista.Constants.TailwindColors

  # ---------------------------------------------------------------------
  # Variables
  # ---------------------------------------------------------------------

  # app
  var :app_bg, ~VAR[color(:cool_gray, 800)]
  var :app_bg_2, ~VAR[color(:cool_gray, 700)]
  var :app_bg_3, ~VAR[color(:cool_gray, 600)]

  # font
  # var :font_sm, ~VAR[size(3)]
  # var :font_md, ~VAR[size(4)]
  # var :font_lg, ~VAR[size(5)]
  # var :font_xl, ~VAR[size(7)]

  # weight
  # var :weight_bold, "500"
  # var :weight_regular, "400"
  # var :weight_light, "300"

  # icon
  # var :icon_sm, ~VAR[size(5)]
  # var :icon_md, ~VAR[size(6)]
  # var :icon_lg, ~VAR[size(7)]

  # color
  var :color_title, ~VAR[color(:cool_gray, 50)]
  var :color_text, ~VAR[color(:cool_gray, 200)]
  var :color_border, ~VAR[color(:cool_gray, 600)]
  var :color_light, ~VAR[color(:cool_gray, 400)]

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

  # page
  # var :page_sidebar_width, ~VAR[size(112)]

  # main
  # var :main_padding, ~VAR[size(4) size(6)]

  # sidebar
  # var :sidebar_padding, ~VAR[size(4)]
  # var :sidebar_width, ~VAR[size(80)]
  # var :sidebar_width_collapsed, ~VAR[size(4)]
  var :sidebar_bg, ~VAR[color(:gray, 700)]

  # ---------------------------------------------------------------------
  # Galeria.Components.Box                               collapsible_box
  # ---------------------------------------------------------------------

  # style :collapsible_box, :base_class, ~CSS""" 
  #   gap: $padding_sm;
  #   width: 100%;
  #   flex-direction: column;
  #   display: flex;
  #   """
  # style :collapsible_box, :header_class, ~CSS""" 
  #   """
  # style :collapsible_box, :content_class, ~CSS""" 
  #   """

  # style :collapsible_box, :status, :open, ~CSS"""
  # """
  # style :collapsible_box, :status, :closed, ~CSS""" 
  # 
  #   .$collapsible_box__content_class {
  #     display: none;
  #   }
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Box                                           box
  # ---------------------------------------------------------------------

  # style :box, :base_class, ~CSS""" 
  #   background: $app_bg_2;
  #   border: 1px solid $color_border;
  #   """

  # style :box, :padding, :sm, ~CSS""" 
  #   padding: $padding_sm;
  #   """
  # style :box, :padding, :md, ~CSS""" 
  #   padding: $padding_md;
  #   """
  # style :box, :padding, :lg, ~CSS""" 
  #   padding: $padding_lg;
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Button                                     button
  # ---------------------------------------------------------------------

  # style :button, :base_class, ~CSS""" 
  #   line-height: 1;
  #   border: none;
  #   cursor: pointer;
  # 
  #   &:hover {
  # 
  #     .$button__icon_class {
  #       fill: $app_bg;
  #     }
  #   }
  #   """
  # style :button, :icon_class, ~CSS""" 
  #   aspect-ratio: 1 / 1;
  # 
  #   .$button__size__sm & {
  #     height: $icon_sm;
  #   }
  # 
  #   .$button__size__md & {
  #     height: $icon_md;
  #   }
  # 
  #   .$button__size__lg & {
  #     height: $icon_lg;
  #   }
  #   """

  # style :button, :size, :sm, ~CSS""" 
  #   font-size: $font_sm;
  #   border-radius: $padding_sm;
  #   padding: $padding_sm;
  #   """
  # style :button, :size, :md, ~CSS""" 
  #   font-size: $font_md;
  #   border-radius: $padding_md;
  #   padding: $padding_md;
  #   """
  # style :button, :size, :lg, ~CSS""" 
  #   font-size: $font_lg;
  #   border-radius: $padding_lg;
  #   padding: $padding_lg;
  #   """

  # style :button, :color, :ctrl, ~CSS""" 
  #   border-color: $color_border;
  #   color: $color_text;
  #   """
  # style :button, :color, :primary, ~CSS""" 
  #   border-color: $brand_regular;
  #   """
  # style :button, :color, :success, ~CSS""" 
  #   border-color: $success_regular;
  #   color: $success_dark;
  #   """
  # style :button, :color, :danger, ~CSS""" 
  #   border-color: $danger_regular;
  #   color: $danger_dark;
  #   """

  # style :button, :style, :solid, ~CSS""" 
  # 
  #   &.$button__color__success {
  #     background: $success_regular;
  #     color: white;
  #   }
  # 
  #   &.$button__color__primary {
  #     background: $brand_regular;
  #     color: white;
  #   }
  # 
  #   &.$button__color__danger {
  #     background: $danger_regular;
  #     color: white;
  #   }
  # 
  #   &.$button__color__ctrl {
  #     background: $color_text;
  #     color: white;
  #   }
  #   """
  # style :button, :style, :soft, ~CSS""" 
  # 
  #   &.$button__color__success {
  #     background: $success_light;
  #     color: $success_regular;
  #   }
  # 
  #   &.$button__color__primary {
  #     background: $brand_light;
  #     color: $brand_regular;
  #   }
  # 
  #   &.$button__color__danger {
  #     background: $danger_light;
  #     color: $danger_regular;
  #   }
  # 
  #   &.$button__color__ctrl {
  #     background: $app_bg_2;
  #     color: $color_text;
  #   }
  #   """
  # style :button, :style, :link, ~CSS""" 
  #   text-decoration: underline;
  # 
  #   &.$button__color__success {
  #     color: $success_regular;
  #   }
  # 
  #   &.$button__color__primary {
  #     color: $brand_regular;
  #   }
  # 
  #   &.$button__color__danger {
  #     color: $danger_regular;
  #   }
  # 
  #   &.$button__color__ctrl {
  #     color: $color_text;
  #   }
  #   """
  # style :button, :style, :transparent, ~CSS""" 
  #   background: transparent;
  # 
  #   &.$button__color__success {
  #     color: $success_regular;
  #   }
  # 
  #   &.$button__color__primary {
  #     color: $brand_regular;
  # 
  #     &:hover {
  #       background: $brand_regular;
  # 
  #       .$button__icon_class {
  #         fill: white;
  #       }
  #     }
  # 
  #     .$button__icon_class {
  #       fill: $brand_regular;
  #     }
  #   }
  # 
  #   &.$button__color__danger {
  #     color: $danger_regular;
  #   }
  # 
  #   &.$button__color__ctrl {
  #     color: $color_text;
  # 
  #     &:hover {
  #       background: $color_text;
  # 
  #       .$button__icon_class {
  #         fill: $app_bg;
  #       }
  #     }
  # 
  #     .$button__icon_class {
  #       fill: $color_light;
  #     }
  #   }
  #   """

  # style :button, :border, :thin, ~CSS""" 
  #   border-style: solid;
  #   border-width: 1px;
  #   """
  # style :button, :border, :thick, ~CSS""" 
  #   border-style: solid;
  #   border-width: 4px;
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Input                                    fieldset
  # ---------------------------------------------------------------------

  # style :fieldset, :base_class, ~CSS""" 
  #   gap: $padding_md;
  #   flex-direction: column;
  #   display: flex;
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Input                                       group
  # ---------------------------------------------------------------------

  # style :group, :base_class, ~CSS""" 
  #   gap: $padding_sm;
  #   """

  # style :group, :direction, :vertical, ~CSS""" 
  #   flex-direction: column;
  #   display: flex;
  #   """
  # style :group, :direction, :horizontal, ~CSS""" 
  #   grid-template-columns: 120px 1fr;
  #   align-items: center;
  #   display: grid;
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Input                                       label
  # ---------------------------------------------------------------------

  # style :label, :base_class, ~CSS""" 
  #   font-weight: $weight_bold;
  #   font-size: $font_sm;
  #   color: $color_light;
  #   text-transform: uppercase;
  #   letter-spacing: 2px;
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Input                                       input
  # ---------------------------------------------------------------------

  # style :input, :base_class, ~CSS""" 
  #   background: transparent;
  #   border-radius: $padding_sm;
  #   border: 1px solid $color_border;
  #   color: $color_text;
  #   padding: $padding_md;
  #   width: 100%;
  #   """

  # style :input, :state, :disabled, ~CSS"""
  # """

  # ---------------------------------------------------------------------
  # Galeria.Components.Input                                    textarea
  # ---------------------------------------------------------------------

  # style :textarea, :base_class, ~CSS""" 
  #   background: transparent;
  #   border-radius: $padding_sm;
  #   border: 1px solid $color_border;
  #   color: $color_text;
  #   padding: $padding_md;
  #   width: 100%;
  #   """

  # style :textarea, :state, :disabled, ~CSS"""
  # """

  # ---------------------------------------------------------------------
  # Galeria.Components.Input                                      select
  # ---------------------------------------------------------------------

  # style :select, :base_class, ~CSS""" 
  #   background: transparent;
  #   border-radius: $padding_sm;
  #   border: 1px solid $color_border;
  #   color: $color_text;
  #   cursor: pointer;
  #   padding: $padding_md;
  #   width: 100%;
  # 
  #   &:hover {
  #     background: $color_border;
  #   }
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Layout                             sidebar_layout
  # ---------------------------------------------------------------------

  # style :sidebar_layout, :base_class, ~CSS""" 
  #   background: $app_bg;
  #   display: grid;
  #   """
  # style :sidebar_layout, :sidebar_class, ~CSS""" 
  #   gap: $padding_lg;
  #   background: $app_bg_2;
  #   border-right: 1px solid $color_border;
  #   padding: $padding_lg;
  #   min-height: 100vh;
  #   flex-grow: 1;
  #   flex-direction: column;
  #   display: flex;
  #   """
  # style :sidebar_layout, :main_class, ~CSS""" 
  #   padding: $main_padding;
  #   flex-grow: 999;
  #   flex-basis: 0;
  #   """

  # style :sidebar_layout, :status, :open, ~CSS""" 
  #   grid-template-columns: $sidebar_width 1fr;
  #   """
  # style :sidebar_layout, :status, :closed, ~CSS""" 
  #   grid-template-columns: $sidebar_width_collapsed 1fr;
  # 
  #   &:hover {
  # 
  #     .$sidebar_layout__sidebar_class {
  #       background: $color_border;
  #     }
  #   }
  # 
  #   .$sidebar_layout__sidebar_class {
  #     cursor: pointer;
  #     padding: 0;
  # 
  #     * {
  #       display: none;
  #     }
  #   }
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Layout                             inspect_layout
  # ---------------------------------------------------------------------

  # style :inspect_layout, :base_class, ~CSS""" 
  #   flex-direction: row;
  #   display: flex;
  #   """
  # style :inspect_layout, :main_class, ~CSS""" 
  #   flex-grow: 999;
  #   flex-direction: column;
  #   flex-basis: 0;
  #   display: flex;
  #   """
  # style :inspect_layout, :sidebar_class, ~CSS""" 
  #   gap: $padding_lg;
  #   padding: $padding_lg;
  #   width: $page_sidebar_width;
  #   flex-grow: 1;
  #   flex-direction: column;
  #   display: flex;
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Layout                                grid_layout
  # ---------------------------------------------------------------------

  # style :grid_layout, :base_class, ~CSS""" 
  #   gap: $padding_lg;
  #   flex-direction: column;
  #   display: flex;
  #   """
  # style :grid_layout, :variant_class, ~CSS""" 
  #   gap: $padding_md;
  #   flex-direction: row;
  #   display: flex;
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Layout                              editor_layout
  # ---------------------------------------------------------------------

  # style :editor_layout, :base_class, ~CSS""" 
  #   gap: $padding_lg;
  #   flex-direction: row;
  #   display: flex;
  #   """
  # style :editor_layout, :main_class, ~CSS""" 
  #   gap: $padding_lg;
  #   flex-grow: 999;
  #   flex-direction: column;
  #   flex-basis: 0;
  #   display: flex;
  #   """
  # style :editor_layout, :preview_class, ~CSS"""
  # """
  # style :editor_layout, :editors_container_class, ~CSS""" 
  #   gap: $padding_lg;
  #   display: grid;
  #   """
  # style :editor_layout, :sidebar_class, ~CSS""" 
  #   gap: $padding_lg;
  #   width: $page_sidebar_width;
  #   flex-grow: 1;
  #   flex-direction: column;
  #   display: flex;
  #   """

  # style :editor_layout, :columns, :one, ~CSS""" 
  # 
  #   .$editor_layour__editors_container_class {
  #     grid-template-columns: 1fr;
  #   }
  #   """
  # style :editor_layout, :columns, :two, ~CSS""" 
  # 
  #   .$editor_layout__editors_container_class {
  #     grid-template-columns: 1fr 1fr;
  #   }
  #   """
  # style :editor_layout, :columns, :three, ~CSS""" 
  # 
  #   .$editor_layout__editors_container_class {
  #     grid-template-columns: 1fr 1fr 1fr;
  #   }
  #   """
  # style :editor_layout, :columns, :four, ~CSS""" 
  # 
  #   .$editor_layout__editors_container_class {
  #     grid-template-columns: 1fr 1fr 1fr 1fr;
  #   }
  #   """
  # style :editor_layout, :columns, :five, ~CSS""" 
  # 
  #   .$editor_layout__editors_container_class {
  #     grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
  #   }
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Nav                                      nav_list
  # ---------------------------------------------------------------------

  # style :nav_list, :base_class, ~CSS""" 
  #   display: flex;
  #   """
  # style :nav_list, :item_class, ~CSS""" 
  #   font-size: $font_md;
  #   border-radius: $padding_md;
  #   color: $color_text;
  #   text-decoration: none;
  #   padding: $padding_md $padding_lg;
  # 
  #   &:hover {
  #     background: $app_bg_3;
  #   }
  #   """
  # style :nav_list, :item_selected_class, ~CSS""" 
  #   background: $app_bg_3;
  #   color: $color_title;
  #   """

  # style :nav_list, :direction, :vertical, ~CSS""" 
  #   gap: $padding_sm;
  #   width: 100%;
  #   flex-direction: column;
  #   """
  # style :nav_list, :direction, :horizontal, ~CSS""" 
  #   gap: $padding_sm;
  #   flex-direction: row;
  # 
  #   .$nav_list__item_class {
  #     width: 100%;
  #   }
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Table                                       table
  # ---------------------------------------------------------------------

  # style :table, :base_class, ~CSS""" 
  #   border-collapse: collapse;
  #   width: 100%;
  # 
  #   & tr .$table__th_class:last-child,
  # & tr .$table__td_class:last-child {
  #     border-right: 0;
  #   }
  # 
  #   & tr .$table__th_class:first-child,
  # & tr .$table__td_class:first-child {
  #     border-left: 0;
  #   }
  # 
  #   & thead tr:first-child .$table__th_class {
  #     border-top: 0;
  #   }
  # 
  #   & tbody tr:last-child .$table__td_class {
  #     border-bottom: 0;
  #   }
  #   """
  # style :table, :th_class, ~CSS""" 
  #   font-weight: $weight_bold;
  #   font-size: $font_sm;
  #   border: 1px solid $color_border;
  #   color: $color_light;
  #   text-transform: uppercase;
  #   letter-spacing: 2px;
  #   text-align: left;
  #   padding: $padding_md;
  #   """
  # style :table, :td_class, ~CSS""" 
  #   border: 1px solid $color_border;
  #   color: $color_text;
  #   padding: $padding_md;
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Typography                          sidebar_title
  # ---------------------------------------------------------------------

  # style :sidebar_title, :base_class, ~CSS""" 
  #   margin-bottom: $padding_lg;
  #   justify-content: space-between;
  #   align-items: center;
  #   display: flex;
  #   """
  # style :sidebar_title, :title_class, ~CSS""" 
  #   font-weight: 800;
  #   font-size: $font_xl;
  #   box-shadow: $app_bg_2 4px 4px 0 -2px, $color_title 4px 4px;
  #   border: 2px solid $color_title;
  #   color: $color_title;
  #   text-transform: uppercase;
  #   letter-spacing: 2px;
  #   text-align: center;
  #   padding: $padding_sm $padding_md;
  #   margin: 0;
  #   """
  # style :sidebar_title, :subtitle_class, ~CSS""" 
  #   font-weight: $weight_regular;
  #   font-size: $font_md;
  #   letter-spacing: 4px;
  #   text-align: center;
  #   display: block;
  #   """
  # style :sidebar_title, :actions_class, ~CSS""" 
  #   gap: $padding_sm;
  #   align-items: center;
  #   display: flex;
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Typography                       sidebar_subtitle
  # ---------------------------------------------------------------------

  # style :sidebar_subtitle, :base_class, ~CSS""" 
  #   justify-content: space-between;
  #   align-items: center;
  #   display: flex;
  #   """
  # style :sidebar_subtitle, :subtitle_class, ~CSS""" 
  #   position: relative;
  #   font-weight: $weight_light;
  #   font-size: $font_md;
  #   color: $color_light;
  #   text-transform: uppercase;
  #   letter-spacing: 2px;
  #   margin: 0;
  # 
  #   &:before {
  #     position: absolute;
  #     border-bottom: 1px solid $color_light;
  #     content: "";
  #     height: 1px;
  #     width: 26px;
  #     left: 0;
  #     bottom: 0;
  #   }
  #   """
  # style :sidebar_subtitle, :actions_class, ~CSS""" 
  #   gap: $padding_sm;
  #   align-items: center;
  #   display: flex;
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Typography                             page_title
  # ---------------------------------------------------------------------

  # style :page_title, :base_class, ~CSS""" 
  #   border-bottom: 1px solid $color_border;
  #   padding-bottom: $padding_md;
  #   margin-bottom: $padding_lg;
  #   justify-content: space-between;
  #   flex-direction: row;
  #   display: flex;
  #   """
  # style :page_title, :title_class, ~CSS""" 
  #   font-weight: $weight_bold;
  #   font-size: $font_lg;
  #   color: $color_title;
  #   margin: 0;
  #   display: inline-flex;
  #   """
  # style :page_title, :subtitle_class, ~CSS""" 
  #   font-weight: $weight_light;
  #   color: $color_light;
  #   display: inline-flex;
  #   """
  # style :page_title, :actions_class, ~CSS""" 
  #   """

  # ---------------------------------------------------------------------
  # Galeria.Components.Typography                          page_subtitle
  # ---------------------------------------------------------------------

  # style :page_subtitle, :base_class, ~CSS""" 
  #   justify-content: space-between;
  #   flex-direction: row;
  #   display: flex;
  #   """
  # style :page_subtitle, :subtitle_class, ~CSS""" 
  #   font-weight: $weight_regular;
  #   font-size: $font_md;
  #   color: $color_light;
  #   margin: 0;
  #   """
  # style :page_subtitle, :actions_class, ~CSS""" 
  #   """
end
