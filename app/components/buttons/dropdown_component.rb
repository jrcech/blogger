# frozen_string_literal: true

module Buttons
  class DropdownComponent < ViewComponent::Base
    def initialize(**button)
      @button = alter_button(**button)
      @dropdown_items = alter_dropdown_items(button[:dropdown_items])
    end

    private

    attr_reader :button, :dropdown_items

    def alter_dropdown_items(dropdown_items)
      dropdown_items.each do |button|
        button[:css_class] = merge_dropdown_class(**button)
      end
    end

    def merge_dropdown_class(**button)
      string = +'dropdown-item'
      string << " #{button[:css_class]}" if button.key?(:css_class)

      string
    end

    def alter_button(**button)
      altered_button = button.except(:dropdown_items)

      altered_button.merge(
        {
          path: '#',
          css_class: merge_css_class(**button),
          aria_expanded: false,
          data: merge_data(**button)
        }
      )
    end

    def merge_data(**button)
      hash = { bs_toggle: 'dropdown' }

      return button[:data].merge(hash) if button[:data].present?

      hash
    end

    def merge_css_class(**button)
      string = +'dropdown-toggle'
      string << " #{button[:css_class]}" if button[:css_class].present?

      string
    end

    def dropdown_element
      return :li if nav_item?

      :div
    end

    def dropdown_class
      string = +'dropdown'
      string << ' nav-item' if nav_item?
      string << " float-#{button[:float]}" if button[:float].present?

      string
    end

    def dropdown_menu_position
      return " dropdown-menu-#{button[:menu_position]}" if button.key?(:menu_position)

      nil
    end

    def nav_item?
      button[:type] == :nav_item
    end

    def dropdown_button_id
      button_id = +''
      button_id << "#{button[:id]}-" if id?
      button_id << 'dropdown-button'
    end

    def id?
      button[:id].present?
    end
  end
end
