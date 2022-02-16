# frozen_string_literal: true

module Utilities
  module ButtonLinksHelper
    attr_reader :button

    def button_link
      link_to(
        button_icon,
        button[:path],
        method: button[:method],
        class: button_class,
        data: button[:data]
      )
    end

    private

    def button_icon
      fa_icon(
        button[:icon],
        text: button[:title],
        fixed_width: button[:icon_fixed_width]
      )
    end
  end
end
