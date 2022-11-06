# frozen_string_literal: true

module Navbars
  class NavbarComponent < ViewComponent::Base
    def initialize(brand:, left_nav:, right_nav:)
      @brand = brand
      @left_nav = left_nav
      @right_nav = right_nav
    end

    private

    attr_reader :brand, :left_nav, :right_nav
  end
end
