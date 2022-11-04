# frozen_string_literal: true

module ButtonsHelper
  def per_page_button(pagination)
    {
      id: 'Per page',
      css_class: 'btn btn-light dropdown-toggle',
      icon: nil,
      title: "#{pagination.vars[:items]} items per page",
      dropdown_items: per_page_dropdown_items(pagination)
    }
  end

  def per_page_dropdown_items(pagination)
    per_page_items = []

    pagination.vars[:per_page].each do |per_page|
      path = request.params.merge({ items: per_page, page: 1 })

      per_page_item = { title: per_page, path: path }

      per_page_items << per_page_item
    end

    per_page_items
  end

  def show_button(item_presenter)
    {
      action: :show,
      path: path_for(:show, item_presenter.id),
      title: t('actions.show'),
      icon: action_icon(:show)
    }
  end

  def new_button
    {
      action: :new,
      path: path_for(:new),
      css_class: 'btn btn-success',
      title: t(
        'actions.new',
        item: t("models.#{model_plural_symbol}.one")
      ),
      icon: action_icon(:new)
    }
  end

  def edit_button(item_presenter, css_class = nil)
    {
      action: :edit,
      path: path_for(:edit, item_presenter.id),
      title: t('actions.edit'),
      css_class: css_class.present? ? css_class : 'btn btn-primary',
      icon: action_icon(:edit)
    }
  end

  def destroy_button(item_presenter, css_class = nil)
    {
      action: :destroy,
      path: path_for(:destroy, item_presenter.id),
      title: t('actions.destroy'),
      css_class: css_class.present? ? css_class : 'btn btn-danger',
      icon: action_icon(:destroy),
      data: destroy_button_data(item_presenter)
    }
  end

  def destroy_button_data(item_presenter)
    model_translation = t("models.#{model_plural_symbol}.one")

    {
      turbo_method: :delete,
      turbo_confirm: t(
        'confirmations.destroy.confirm',
        item: item_presenter.title
      ),
      title: t(
        'confirmations.destroy.title',
        model: model_translation
      ),
      commit: t(
        'confirmations.destroy.commit',
        model: model_translation
      ),
      cancel: t('confirmations.destroy.cancel')
    }
  end
end
