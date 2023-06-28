# frozen_string_literal: true

module Forms
  class CommentsFormComponent < ViewComponent::Base
    def initialize(comment:)
      @comment = comment
    end

    private

    attr_reader :comment
  end
end
