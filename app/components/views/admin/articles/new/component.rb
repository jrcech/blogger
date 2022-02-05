# frozen_string_literal: true

module Views
  module Admin
    module Articles
      module New
        class Component < ViewComponent::Base
          include Utilities::ModelHelper
          include Utilities::FontAwesomeHelper
          include Utilities::TooltipHelper

          def initialize(item:)
            @item = item
          end

          private

          attr_reader :item
        end
      end
    end
  end
end
