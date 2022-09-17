# frozen_string_literal: true

module Tables
  class TableComponent < ViewComponent::Base
    def initialize(collection:, thead: nil)
      @collection = collection
      @thead = thead
    end

    private

    attr_reader :collection, :thead
  end
end
