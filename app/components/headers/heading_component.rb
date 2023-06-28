# frozen_string_literal: true

module Headers
  class HeadingComponent < ViewComponent::Base
    def initialize(header:, main_header:, buttons:)
      @header = header
      @main_header = main_header
      @buttons = buttons
    end

    private

    attr_reader :header, :main_header, :buttons

    def render?
      main_header
    end
  end
end
