module ApplicationHelper
  include Pagy::Frontend

  def application_name
    Rails.application.class.module_parent_name
  end
end
