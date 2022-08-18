# frozen_string_literal: true

module Elements
  module Footer
    class Component < ViewComponent::Base
      include Utilities::PathsHelper
      include Utilities::ResourceHelper
      include Utilities::ModelHelper
      include Utilities::ControllerHelper
      include Utilities::FontAwesomeHelper
      include Pagy::Frontend
      include Buttons::Dropdown::Presets

      def initialize(left_dropdown: nil, pagination: nil)
        @left_dropdown = left_dropdown
        @pagination = pagination
      end

      private

      attr_reader :left_dropdown, :pagination

      def left_dropdown?
        left_dropdown.present?
      end

      def pagination?
        pagination.present?
      end
    end
  end
end
