# frozen_string_literal: true

module Views
  module Admin
    module Articles
      module Show
        class Component < ViewComponent::Base
          include Utilities::ModelHelper
          include Utilities::FontAwesomeHelper
          include Utilities::TooltipHelper

          include Utilities::PathsHelper
          include Utilities::ResourceHelper
          include Utilities::ControllerHelper

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
            [
              edit_button,
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

          def edit_button
            {
              action: :edit,
              path: path_for(:edit, item_presenter.id),
              title: t('actions.edit'),
              css_class: 'btn btn-primary',
              icon: action_icon(:edit)
            }
          end

          def destroy_button
            {
              action: :destroy,
              path: path_for(:destroy, item_presenter.id),
              title: t('actions.destroy'),
              css_class: 'btn btn-danger',
              icon: action_icon(:destroy),
              data: destroy_button_data
            }
          end

          def destroy_button_data
            model_translation = t("models.#{model_plural_symbol}.one")
            {
              turbo_method: :delete,
              turbo_confirm: t('confirmations.destroy.confirm', item: item_presenter.title),
              title: t('confirmations.destroy.title', model: model_translation),
              commit: t('confirmations.destroy.commit', model: model_translation),
              cancel: t('confirmations.destroy.cancel')
            }
          end
        end
      end
    end
  end
end
