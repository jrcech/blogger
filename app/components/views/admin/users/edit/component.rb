# frozen_string_literal: true

module Views
  module Admin
    module Users
      module Edit
        class Component < ViewComponent::Base
          include Utilities::ModelHelper
          include Utilities::FontAwesomeHelper
          include Utilities::TooltipHelper

          def initialize(item:, item_presenter:)
            @item = item
            @item_presenter = item_presenter
          end

          private

          attr_reader :item, :item_presenter
        end
      end
    end
  end
end
