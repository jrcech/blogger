# frozen_string_literal: true

module Forms
  class ArticlesFormComponent < ViewComponent::Base
    def initialize(article:)
      @article = article
    end

    private

    attr_reader :article
  end
end
