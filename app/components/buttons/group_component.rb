# frozen_string_literal: true

module Buttons
  class GroupComponent < ViewComponent::Base
    def initialize(buttons:, title: nil)
      @buttons = buttons
      @title = title
    end

    private

    attr_reader :buttons, :title

    def aria_label_title
      return "#{title} buttons" if title?

      'Buttons group'
    end

    def title?
      title.present?
    end
  end
end
