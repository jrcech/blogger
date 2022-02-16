# frozen_string_literal: true

module Views
  module Admin
    module Users
      module Index
        class Component < ViewComponent::Base
          include Utilities::ModelHelper
          include Utilities::FontAwesomeHelper
          include Utilities::TooltipHelper

          def initialize(items:, search_query:, pagy:)
            @items = items
            @search_query = search_query
            @pagy = pagy
          end

          private

          attr_reader :items, :search_query, :pagy

          def header
            {
              title: t("models.#{model_plural_symbol}.more"),
              icon: model_icon(model_plural_symbol)
            }
          end

          def thead
            [
              [
                t('tables.headings.id'),
                search_icon(t('tables.headings.name')),
                search_icon(t('tables.headings.email')),
                t('models.roles.one')
              ]
            ]
          end

          def tbody
            %i[
              id
              highlight_full_name
              highlight_email
              user_role
            ]
          end

          def action_buttons
            [
              {
                ellipsis_button: %i[
                  edit_button
                  divider
                  destroy_button
                ]
              }
            ]
          end
        end
      end
    end
  end
end
