# frozen_string_literal: true

module Headers
  class HeadingComponent < ViewComponent::Base
    def initialize(header:, main_header:)
      @header = header
      @main_header = main_header
    end

    private

    attr_reader :header, :main_header
  end
end
