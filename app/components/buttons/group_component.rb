# frozen_string_literal: true

module Buttons
  class GroupComponent < ViewComponent::Base
    def initialize(buttons:, title: nil, item: nil)
      @buttons = buttons
      @title = title
      @item = item
    end

    private

    attr_reader :buttons, :title, :item

    def aria_label_title
      return "#{title} buttons" if title?

      'Buttons group'
    end

    def title?
      title.present?
    end
  end
end
