# frozen_string_literal: true

module Elements
  module Buttons
    module Button
      module Actions
        module Crud
          private

          def show_button
            {
              action: :show,
              path: path_for(:show, item),
              title: t('actions.show'),
              icon: action_icon(:show)
            }
          end

          def new_button
            {
              action: :new,
              path: path_for(:new),
              title: t(
                'actions.new',
                item: t("models.#{model_plural_symbol}.one")
              ),
              icon: action_icon(:new)
            }
          end

          def edit_button
            {
              action: :edit,
              path: path_for(:edit, item),
              title: t('actions.edit'),
              icon: action_icon(:edit)
            }
          end

          def destroy_button
            {
              action: :destroy,
              path: path_for(:destroy, item),
              title: t('actions.destroy'),
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
