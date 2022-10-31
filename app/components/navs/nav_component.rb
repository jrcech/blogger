# frozen_string_literal: true

module Navs
  class NavComponent < ViewComponent::Base
    def initialize(nav_items:, **options)
      @nav_items = alter_nav_items(nav_items)
      @options = options
    end

    private

    attr_reader :nav_items, :options

    def alter_nav_items(nav_items)
      nav_items.each do |button|
        button[:css_class] = merge_css_class(**button)
      end
    end

    def merge_css_class(**button)
      string = +'nav-link'
      string << " #{button[:css_class]}" if button.key?(:css_class)

      string
    end

    def nav_attributes
      {
        class: construct_class,
        id: construct_id
      }
    end

    def construct_class
      "navbar-nav#{left_nav_class}"
    end

    def left_nav_class
      return ' me-auto' if left_nav?

      nil
    end

    def left_nav?
      options&.dig(:type) == :left_nav
    end

    def construct_id
      options&.dig(:id)
    end
  end
end
