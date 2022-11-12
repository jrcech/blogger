# frozen_string_literal: true

class ReviewPresenter < ModelPresenter
  def highlight_title
    highlight(title, search_query)
  end

  def truncate_content
    content.truncate(100)
  end

  def article_title
    article.title
  end
end
