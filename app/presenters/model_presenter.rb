# frozen_string_literal: true

class ModelPresenter
  include ActionView::Helpers

  delegate_missing_to :item

  def initialize(item:, search_query: nil)
    @item = item
    @search_query = search_query
  end

  private

  attr_reader :item, :search_query

  # def model_name
  #   item.class.name.underscore
  # end
end
