class ApplicationController < ActionController::Base
  include Pagy::Backend

  around_action :switch_locale

  before_action :set_layout_decorator

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def set_layout_decorator
    @admin_decorator = Layouts::AdminDecorator.new(
      :left_nav,
      controller_name,
      current_user
    )
  end
end
