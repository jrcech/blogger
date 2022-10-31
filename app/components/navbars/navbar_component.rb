# frozen_string_literal: true

module Navbars
  class NavbarComponent < ViewComponent::Base
    def initialize(left_nav:, right_nav:)
      @left_nav = left_nav
      @right_nav = right_nav
    end

    private

    attr_reader :left_nav, :right_nav
  end
end
