# frozen_string_literal: true

module Headers
  class PagyInfoComponent < ViewComponent::Base
    include Pagy::Frontend

    def initialize(pagy:)
      @pagy = pagy
    end

    def render?
      pagy.present? && action_name != 'show'
    end

    private

    attr_reader :pagy
  end
end
