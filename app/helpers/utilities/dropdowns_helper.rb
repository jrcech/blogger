# frozen_string_literal: true

module Utilities
  module DropdownsHelper
    attr_reader :buttons, :button

    def dropdown_separator
      { separator: true }
    end

    def construct_dropdown_class
      "#{dropdown_class}#{dropdown_color_class}#{caret_class}"
    end

    def dropdown_items
      buttons.compact!

      buttons.each do |dropdown_item|
        next if dropdown_item[:separator].present?

        dropdown_item.merge!(dropdown_properties)
      end

      buttons
    end

    def dropdown_properties
      {
        dropdown: true,
        icon_fixed_width: true
      }
    end

    private

    def dropdown_class
      return nil unless button.key? :dropdown

      ' dropdown-item'
    end

    def dropdown_color_class
      return nil unless button.key? :dropdown
      return " text-#{bootstrap_class}" if bootstrap_class.present?

      nil
    end

    def caret_class
      return ' dropdown-toggle' if button[:caret].present?

      nil
    end

    def dropdown_button
      button_icon = button[:icon]
      button_title = button[:title]

      return fa_icon button_icon, text: button_title if button_icon.present?

      button_title
    end

    def dropdown_button_id(title)
      transliterated_title = I18n.transliterate(title.tr(' ', '_').camelize(:lower))

      "#{transliterated_title}DropdownMenuButton"
    end

    def dropdown_menu_class
      " dropdown-menu#{dropdown_menu_position}"
    end

    def dropdown_menu_position
      menu_position = button[:menu_position]

      return " dropdown-menu-#{menu_position}" if menu_position.present?

      nil
    end
  end
end
