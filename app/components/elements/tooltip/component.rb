# frozen_string_literal: true

module Elements
  module Tooltip
    class Component < ViewComponent::Base
      def initialize(icon:, title:, **options)
        @icon = icon
        @title = title
        @options = options
      end

      private

      attr_reader :title, :icon, :options

      def construct_options
        options.deep_merge(construct_data)
      end

      def construct_data
        hash = { data: { bs_target: :tooltip } }
        hash[:data][:bs_placement] = placement if placement?

        hash
      end

      def placement
        return options[:placement] if placement?

        nil
      end

      def placement?
        options&.dig(:placement).present?
      end
    end
  end
end
