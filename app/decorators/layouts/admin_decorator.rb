# frozen_string_literal: true

module Layouts
  class AdminDecorator
    include Rails.application.routes.url_helpers
    include I18n::Base
    include Utilities::FontAwesomeHelper

    def initialize(type, controller_name, current_user)
      @type = type
      @controller_name = controller_name
      @current_user = current_user
    end

    def left_nav
      [
        homepage_button,
        users_button,
        articles_button
      ]
    end

    def right_nav
      [
        user_signed_in? ? user_dropdown : login_button
      ]
    end

    private

    attr_reader :type, :controller_name, :current_user

    def homepage_button
      {
        path: admin_root_path,
        title: 'Dashboard',
        controller: 'dashboard',
        class: "nav-link#{active_class('dashboard')}"
      }
    end

    def users_button
      {
        path: admin_users_path,
        icon: model_icon(:users),
        title: t('models.users.more'),
        controller: 'users',
        class: "nav-link#{active_class('users')}"
      }
    end

    def articles_button
      {
        path: admin_articles_path,
        icon: model_icon(:articles),
        title: t('models.articles.more'),
        controller: 'articles',
        class: "nav-link#{active_class('articles')}"
      }
    end

    def active_class(controller)
      return ' active' if active?(controller)

      nil
    end

    def active?(controller)
      return true if controller_name == controller

      false
    end

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
        menu_position: 'right',
        css_class: 'nav-item',
        dropdown_items: [
          {
            icon: 'power-off',
            title: 'Sign out',
            size: 'sm',
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
        icon: 'sign-in-alt',
        title: 'Log in',
        size: 'sm',
        path: new_user_session_path,
        class: 'nav-item'
      }
    end
  end
end
