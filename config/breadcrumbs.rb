crumb :root do
  link t('controller.dashboard'), admin_root_path
end

crumb :records do |model_symbol_plural|
  link(
    render(
      Tooltips::TooltipComponent.new(
        icon: model_icon(model_symbol_plural),
        title: t("models.#{model_symbol_plural}.more")
      )
    ),
    send("admin_#{model_symbol_plural}_path")
  )
end

crumb :record do |record, record_presenter|
  link record_presenter.title, send("admin_#{record_presenter.model_symbol}_path", id: record.id)

  parent :records, record_presenter.model_symbol_plural
end

crumb :new do |model_symbol_plural|
  link t('actions.new', record: model_symbol_plural.to_s.singularize), send("new_admin_#{model_symbol_plural.to_s.singularize}_path")

  parent :records, model_symbol_plural
end

crumb :edit do |record, record_presenter|
  link t('actions.edit'), send("edit_admin_#{record_presenter.model_symbol}_path", id: record.id)

  parent :record, record, record_presenter
end

crumb :reviews do |article, article_presenter|
  if article.present?
    link(
      render(
        Tooltips::TooltipComponent.new(
          icon: model_icon('reviews'),
          title: t("models.reviews.more")
        )
      ),
      admin_article_reviews_path(article)
    )


    parent :record, article, article_presenter
  else
    link(
      render(
        Tooltips::TooltipComponent.new(
          icon: model_icon('reviews'),
          title: t("models.reviews.more")
        )
      ),
      admin_reviews_path
    )


    parent :root
  end
end

crumb :comments do |comment, comment_presenter|
  if comment.present?
    link(
      render(
        Tooltips::TooltipComponent.new(
          icon: model_icon('comments'),
          title: t("models.comments.more")
        )
      ),
      admin_article_comments_path(comment)
    )


    parent :record, comment, comment_presenter
  else
    link(
      render(
        Tooltips::TooltipComponent.new(
          icon: model_icon('comments'),
          title: t("models.comments.more")
        )
      ),
      admin_comments_path
    )


    parent :root
  end
end

crumb :technologies do |technology, technology_presenter|
  if technology.present?
    link(
      render(
        Tooltips::TooltipComponent.new(
          icon: model_icon('technologies'),
          title: t("models.technologies.more")
        )
      ),
      admin_article_technologies_path(technology)
    )


    parent :record, technology, technology_presenter
  else
    link(
      render(
        Tooltips::TooltipComponent.new(
          icon: model_icon('technologies'),
          title: t("models.technologies.more")
        )
      ),
      admin_technologies_path
    )


    parent :root
  end
end
