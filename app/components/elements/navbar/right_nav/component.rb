# frozen_string_literal: true

module Elements
  module Navbar
    module RightNav
      class Component < ViewComponent::Base
        include Utilities::LocaleHelper
        include Utilities::I18nHelper
        include Utilities::FontAwesomeHelper

        def initialize(current_user:)
          @current_user = current_user
        end

        def create_nav_items
          @nav_items = [
            locales_dropdown,
            user_signed_in? ? user_dropdown : login_button
          ]
        end

        private

        attr_reader :current_user

        def user_signed_in?
          return true if current_user.present?

          false
        end

        def locales_dropdown
          {
            title: I18n.locale.upcase,
            dropdown_items: available_locales
          }
        end

        def user_dropdown
          {
            title: current_user.present? ? UserPresenter.new(item: current_user).full_name : nil,
            dropdown_items: [
              {
                title: render(
                  Elements::FontAwesome::Component.new(
                    icon: 'power-off',
                    title: 'Sign out',
                    text: 'Sign out',
                    size: 'sm'
                  )
                ),
                path: destroy_user_session_path,
                data: {
                  turbo_method: :delete
                }
              },
              {
                title: 'Edit password',
                path: edit_user_registration_path
              }
            ]
          }
        end

        def login_button
          {
            title: render(
              Elements::FontAwesome::Component.new(
                icon: 'sign-in-alt',
                title: 'Log in',
                text: 'Log in',
                size: 'sm'
              )
            ),
            path: new_user_session_path,
            class: 'nav-item'
          }
        end
      end
    end
  end
end
