# frozen_string_literal: true

crumb :root do
  link t('controller.dashboard'), admin_root_path
end

crumb :items do |model_symbol_plural|
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

crumb :item do |item, item_presenter|
  link item_presenter.title, send("admin_#{item_presenter.model_symbol}_path", id: item.id)

  parent :items, item_presenter.model_symbol_plural
end

crumb :new do |model_symbol_plural|
  link t('actions.new', item: model_symbol_plural.to_s.singularize), send("new_admin_#{model_symbol_plural.to_s.singularize}_path")

  parent :items, model_symbol_plural
end

crumb :edit do |item, item_presenter|
  link t('actions.edit'), send("edit_admin_#{item_presenter.model_symbol}_path", id: item.id)

  parent :item, item, item_presenter
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


    parent :item, article, article_presenter
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
