# frozen_string_literal: true

module Searchable
  extend ActiveSupport::Concern

  def search
    @search_query = params[:search_query]

    @pagy, @items = pagy(
      find_items.search_by(@search_query),
      page: params[:page],
      items: params[:items]
    )

    render :index
  end
end
