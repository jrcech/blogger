# frozen_string_literal: true

class UserPresenter < ModelPresenter
  def full_name
    "#{first_name} #{last_name}"
  end

  alias title full_name

  def highlight_full_name
    highlight(full_name, search_query)
  end

  def highlight_email
    highlight(email, search_query)
  end

  def user_role
    role.to_s.titleize
  end
end
