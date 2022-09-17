# frozen_string_literal: true

module Tables
  class HeadComponent < ViewComponent::Base
    def initialize(thead:)
      @thead = thead
    end

    def render?
      thead.present?
    end

    private

    attr_reader :thead
  end
end
