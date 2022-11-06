# frozen_string_literal: true

module Forms
  class ReviewsFormComponent < ViewComponent::Base
    def initialize(review:)
      @review = review
    end

    private

    attr_reader :review
  end
end
