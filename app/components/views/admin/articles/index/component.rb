# frozen_string_literal: true

module Views
  module Admin
    module Articles
      module Index
        class Component < ViewComponent::Base
          include Utilities::ModelHelper
          include Utilities::FontAwesomeHelper
          include Utilities::TooltipHelper

          #TODO
          include Utilities::PathsHelper
          include Utilities::ResourceHelper
          include Utilities::ControllerHelper

          def initialize(items:, search_query:, pagy:)
            @items = items
            @search_query = search_query
            @pagy = pagy
          end

          private

          attr_reader :items, :search_query, :pagy

          #TODO
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

          def the_data
            collection = []

            items.each do |item|
              item_presenter = "#{item.class}Presenter".constantize.new(
                item: item, search_query: search_query
              )

              cells = item_cells(item_presenter)

              cells << index_buttons(item_presenter)

              collection << { cells: cells, show_path: path_for(:show, item) }
            end

            collection
          end

          def item_cells(item_presenter)
            cells = []

            tbody.each do |cell|
              cells << item_presenter.send(cell)
            end

            cells
          end

          def index_buttons(item_presenter)
            render Buttons::DropdownComponent.new(
              id: item_presenter.id,
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

          def show_button(item_presenter)
            {
              action: :show,
              path: path_for(:show, item_presenter.id),
              title: t('actions.show'),
              icon: action_icon(:show)
            }
          end

          def edit_button(item_presenter)
            {
              action: :edit,
              path: path_for(:edit, item_presenter.id),
              title: t('actions.edit'),
              icon: action_icon(:edit)
            }
          end

          def destroy_button(item_presenter)
            {
              action: :destroy,
              path: path_for(:destroy, item_presenter.id),
              title: t('actions.destroy'),
              icon: action_icon(:destroy),
              data: destroy_button_data(item_presenter)
            }
          end

          def destroy_button_data(item_presenter)
            model_translation = t("models.#{model_plural_symbol}.one")
            {
              turbo_method: :delete,
              turbo_confirm: t('confirmations.destroy.confirm', item: item_presenter.title),
              title: t('confirmations.destroy.title', model: model_translation),
              commit: t('confirmations.destroy.commit', model: model_translation),
              cancel: t('confirmations.destroy.cancel')
            }
          end

          def header
            {
              title: t("models.#{model_plural_symbol}.more"),
              icon: model_icon(model_plural_symbol)
            }
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

          def tbody
            %i[
              id
              highlight_title
              truncate_content
            ]
          end

          def left_dropdown(pagination)
            {
              id: 'Per page',
              class: 'btn btn-light dropdown-toggle',
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
        end
      end
    end
  end
end
