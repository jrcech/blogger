# frozen_string_literal: true

class ArticlePresenter < ModelPresenter
  def highlight_title
    highlight(title, search_query)
  end

  def truncate_content
    content.truncate 100
  end
end
