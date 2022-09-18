# frozen_string_literal: true

module TablesHelper
  def articles_data(items, tbody)
    collection = []

    items.each do |item|
      item_presenter = "#{item.class}Presenter".constantize.new(
        item:,
        search_query: @search_query
      )

      cells = item_cells(item_presenter, tbody)

      cells << index_buttons(item_presenter)

      collection << { cells:, show_path: path_for(:show, item) }
    end

    collection
  end

  def item_cells(item_presenter, tbody)
    cells = []

    tbody.each do |cell|
      cells << item_presenter.send(cell)
    end

    cells
  end

  def index_buttons(item_presenter)
    render Buttons::DropdownComponent.new(
      id: "#{item_presenter.id}-dropdown-button",
      float: 'end',
      css_class: 'btn btn-light',
      icon: 'ellipsis-v',
      dropdown_items: [
        show_button(item_presenter),
        edit_button(item_presenter),
        destroy_button(item_presenter)
      ]
    )
  end

  def thead
    [
      {
        cells: [
          t('tables.headings.id'),
          search_icon(t('tables.headings.title')),
          search_icon(t('tables.headings.content'))
        ]
      }
    ]
  end
end
