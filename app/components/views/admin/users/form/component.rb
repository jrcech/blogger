# frozen_string_literal: true

module Views
  module Admin
    module Users
      module Form
        class Component < ViewComponent::Base
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
