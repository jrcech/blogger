# frozen_string_literal: true

class ModelPresenter
  include ActionView::Helpers

  delegate_missing_to :item

  def initialize(item:, search_query: nil)
    @item = item
    @search_query = search_query
  end

  def model_symbol
    item.class.name.underscore
  end

  private

  attr_reader :item, :search_query
end
