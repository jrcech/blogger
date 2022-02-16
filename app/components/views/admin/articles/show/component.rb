# frozen_string_literal: true

module Views
  module Admin
    module Articles
      module Show
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

          def header
            {
              title: item_presenter.title,
              icon: model_icon(model_plural_symbol)
            }
          end

          def action_buttons
            %i[
              edit_button
              destroy_button
            ]
          end

          def details
            %i[
              id
              title
              content
            ]
          end
        end
      end
    end
  end
end
