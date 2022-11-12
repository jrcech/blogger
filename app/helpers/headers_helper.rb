# frozen_string_literal: true

module HeadersHelper
  def overview_header
    {
      title: 'Overview',
      icon: 'magnifying-glass'
    }
  end

  def index_header(model)
    {
      title: model.to_s.humanize,
      icon: model_icon(model),
      model: model
    }
  end

  def header(item)
    {
      title: header_title(item),
      icon: model_icon(item.model_name.plural),
      model: item.model_name.plural
    }
  end

  def header_title(item)
    return item.title if item.present?

    t("models.#{item.model_name.plural}.more")
  end
end
