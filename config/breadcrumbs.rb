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
    path_for(:index)
  )
end

crumb :item do |item, item_presenter|
  link item_presenter.title, path_for(:show, item)

  parent :items
end

crumb :new do
  link t('actions.new', item: model_singular), path_for(:new)

  parent :items
end

crumb :edit do |item, item_presenter|
  link t('actions.edit'), path_for(:edit, item)

  parent :item, item, item_presenter
end
