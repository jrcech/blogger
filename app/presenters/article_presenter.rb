class ArticlePresenter < ModelPresenter
  def highlight_title
    highlight(title, search_query)
  end

  def truncate_content
    content.truncate(100)
  end

  def highlight_truncate_content
    highlight(truncate_content, search_query)
  end
end
