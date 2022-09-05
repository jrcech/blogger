# frozen_string_literal: true

module Buttons
  class LinkComponent < ViewComponent::Base
    def initialize(**button)
      @button = button
    end

    private

    attr_reader :button

    def construct_title
      return button[:title] if button[:icon].blank?

      render(
        Elements::FontAwesome::Component.new(
          icon: button[:icon],
          title: button[:title],
          text: button[:title]
        )
      )
    end

    def construct_class
      return button[:css_class] if button.key?(:css_class)

      'btn btn-primary'
    end
  end
end
