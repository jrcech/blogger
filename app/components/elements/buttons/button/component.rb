# frozen_string_literal: true

module Elements
  module Buttons
    module Button
      class Component < ViewComponent::Base
        include Utilities::FontAwesomeHelper
        include ViewDecorator
        include Buttons::Button::Actions::Crud
        include Buttons::Button::Actions::Role

        with_collection_parameter :button

        def initialize(title:, path:, button: nil, **options)
          @title = title
          @path = path
          @button = button
          @options = options
          # @item_presenter = options.&dig(:item).present? ? initialize_item_presenter : nil
        end

        # def create_button
        #   @button = evaluate_button
        #
        #   construct_button
        # end

        private

        attr_reader(
          :button,
          :title,
          :path,
          :item_presenter,
          :options
        )

        # def initialize_item_presenter
        #   item_presenter_class = "#{options.&dig(:item).class}Presenter"
        #
        #   item_presenter_class.constantize.new(item: item)
        # end
        #
        # def evaluate_button
        #   evaluated_button = button_hash
        #   evaluated_button.merge! icon_fixed_width: true if dropdown_item?
        #
        #   evaluated_button
        # end
        #
        # def button_hash
        #   return button if button.is_a? Hash || divider?
        #
        #   send button
        # end
        #
        # def dropdown_item?
        #   type == :dropdown_item
        # end
        #
        # def nav_item?
        #   type == :nav_item
        # end
        #
        # def divider?
        #   button == :divider
        # end
        #
        # def construct_button
        #   link_to(
        #     title_with_icon,
        #     path,
        #     method: options[:link_method],
        #     class: button_class,
        #     role: 'button',
        #     id: options[:id],
        #     'aria-expanded': options[:aria_expanded],
        #     data: options[:data]
        #   )
        # end
        #
        def construct_title
          return title if options[:icon].blank?

          render(
            Elements::FontAwesome::Component.new(
              icon: options[:icon],
              title: title,
              text: title
            )
          )
        end
        #
        # def button_class
        #   "#{construct_button_class}#{construct_dropdown_class}"
        # end
        #
        # def construct_button_class
        #   return nil if dropdown_item?
        #   return 'nav-link' if nav_item?
        #   return options[:css_class] if options.key? :css_class
        #   return "btn btn-#{bootstrap_class}" if bootstrap_class.present?
        #
        #   'btn btn-primary'
        # end
        #
        # def construct_dropdown_class
        #   "#{dropdown_class}#{dropdown_color_class}"
        # end
        #
        # def dropdown_class
        #   return nil unless dropdown_item?
        #
        #   'dropdown-item'
        # end
        #
        # def dropdown_color_class
        #   return nil unless dropdown_item?
        #   return " text-#{bootstrap_class}" if bootstrap_class.present?
        #
        #   nil
        # end
        #
        # def bootstrap_class
        #   {
        #     new: 'success',
        #     edit: 'primary',
        #     destroy: 'danger',
        #     make_admin: 'secondary',
        #     make_member: 'warning'
        #   }[options[:action]]
        # end
      end
    end
  end
end
