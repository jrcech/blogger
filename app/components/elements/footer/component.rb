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

      def initialize(pagination: nil, left_dropdown: nil)
        @pagination = pagination
        @left_dropdown = left_dropdown
      end

      private

      attr_reader :pagination, :left_dropdown

      def pagination?
        pagination.present?
      end

      def left_dropdown?
        left_dropdown.present?
      end
    end
  end
end
