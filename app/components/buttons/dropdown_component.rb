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
        button[:css_class] = dropdown_item_class(**button)
      end
    end

    def dropdown_item_class(**button)
      return button[:css_class] if button.key?(:css_class)

      'dropdown-item'
    end

    def alter_button(**button)
      altered_button = button.except(:dropdown_items, :wrapper_element)

      altered_button.merge(
        {
          path: '#',
          css_class: toggle_class(**button),
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

    def toggle_class(**button)
      return button[:toggle_class] if button.dig(:toggle_class).present?

      'dropdown-toggle'
    end

    def dropdown_element(**button)
      return button[:element] if button.dig(:element).present?

      :div
    end

    def dropdown_class(**button)
      return button[:dropdown_class] if button.dig(:dropdown_class).present?

      'dropdown'
    end

    def menu_class(**button)
      return button[:menu_class] if button.dig(:menu_class).present?

      'dropdown-menu'
    end
  end
end
