# frozen_string_literal: true

crumb :root do
  link t('controller.dashboard'), admin_root_path
end

crumb :items do
  link(
    render(
      Tooltips::TooltipComponent.new(
        icon: model_icon(model_plural_symbol),
        title: t("models.#{model_plural_symbol}.more")
      )
    ),
    send("admin_#{model_plural_symbol}_path")
  )
end

crumb :item do |item, item_presenter|
  link item_presenter.title, send("admin_#{item_presenter.model_symbol}_path", id: item.id)

  parent :items
end

crumb :new do
  link t('actions.new', item: model_singular), send("new_admin_#{model_singular_symbol}_path")

  parent :items
end

crumb :edit do |item, item_presenter|
  link t('actions.edit'), send("edit_admin_#{item_presenter.model_symbol}_path", id: item.id)

  parent :item, item, item_presenter
end

crumb :articles do
  link(
    render(
      Tooltips::TooltipComponent.new(
        icon: model_icon('articles'),
        title: t("models.articles.more")
      )
    ),
    admin_articles_path
  )
end

crumb :article do |article, article_presenter|
  link article_presenter.title, admin_article_path(article)

  parent :articles
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


    parent :article, article, article_presenter
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
