# frozen_string_literal: true

class ArticlePresenter < ModelPresenter
  def highlight_title
    highlight(title, search_query)
  end

  def highlight_truncate_content
    highlight(content.truncate(100), search_query)
  end
end
