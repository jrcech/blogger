# frozen_string_literal: true

module Forms
  class UsersFormComponent < ViewComponent::Base
    def initialize(user:)
      @user = user
    end

    private

    attr_reader :user
  end
end
