# frozen_string_literal: true

module Elements
  module Nav
    class Component < ViewComponent::Base
      include Utilities::FontAwesomeHelper

      def initialize(nav_items:, **options)
        @nav_items = nav_items
        @options = options
      end

      private

      attr_reader :nav_items, :options

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
end
