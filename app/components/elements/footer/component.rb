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

      def initialize(pagination: nil, pagy_dropdown_items: nil)
        @pagination = pagination
        @pagy_dropdown_items = pagy_dropdown_items
      end

      private

      attr_reader :pagination, :pagy_dropdown_items

      def pagination?
        pagination.present?
      end
    end
  end
end
