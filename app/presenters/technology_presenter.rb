class TechnologyPresenter < ModelPresenter
  def highlight_title
    highlight(title, search_query)
  end

  def highlight_shortcut
    highlight(shortcut, search_query)
  end
end
