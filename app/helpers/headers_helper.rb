# frozen_string_literal: true

module HeadersHelper
  def header(item_presenter = nil)
    {
      title: header_title(item_presenter),
      icon: model_icon(model_plural_symbol),
      model: model_plural_symbol
    }
  end

  def header_title(item_presenter)
    return item_presenter.title if item_presenter.present?

    t("models.#{model_plural_symbol}.more")
  end
end
