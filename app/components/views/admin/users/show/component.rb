# frozen_string_literal: true

module Views
  module Admin
    module Users
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
            [:edit_button]
          end

          def details
            %i[
              id
              email
              first_name
              last_name
              username
              confirmation_sent_at
              confirmed_at
              current_sign_in_at
              current_sign_in_ip
              failed_attempts
              last_sign_in_at
              last_sign_in_ip
              locked_at
              provider
              remember_created_at
              reset_password_sent_at
              sign_in_count
              uid
              unconfirmed_email
              created_at
              updated_at
            ]
          end
        end
      end
    end
  end
end
