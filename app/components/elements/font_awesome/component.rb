# frozen_string_literal: true

module Elements
  module FontAwesome
    class Component < ViewComponent::Base
      def initialize(icon:, title:, **options)
        @icon = icon
        @title = title
        @options = options
      end

      private

      attr_reader :icon, :title, :options

      def construct_class
        "#{style}#{construct_icon}#{size}#{fixed_width}" +
          + "#{animation}#{rotation}#{border}#{pull}"
      end

      def construct_data
        return { controller: 'font-awesome' } if options&.dig(:data).blank?

        hash = options[:data]
        hash[:controller] = construct_controller

        hash
      end

      def construct_controller
        controller = options[:data][:controller]

        return 'font-awesome' if controller.blank?

        "font-awesome #{controller}"
      end

      def style
        style = options&.dig :style
        return style if style.present?

        'fa-solid'
      end

      def construct_icon
        " fa-#{icon}"
      end

      def size
        size = options&.dig :size
        return " fa-#{size}" if size.present?

        nil
      end

      def animation
        animation = options&.dig :animation
        return " fa-#{animation}" if animation.present?

        nil
      end

      def fixed_width
        return ' fa-fw' if options&.dig(:fixed_width) || options&.dig(:text)

        nil
      end

      def rotation
        rotation = options&.dig :rotation
        return " fa-#{rotation}" if rotation.present?

        nil
      end

      def border
        return ' fa-border' if options&.dig :border

        nil
      end

      def pull
        position = options&.dig :pull
        return " fa-pull-#{position}" if position.present?

        nil
      end

      def construct_data_hash
        data = {}

        options[:data].each do |key, value|
          data << "#{key.to_s.dasherize}='#{value}'"
        end

        data
      end

      def construct_title
        title = options&.dig :title
        "title='#{title}'" if title.present?
      end

      def model_icon(model)
        icons = YAML.load_file('config/icons.yml')
        icons['models'][model.to_s]
      end

      def action_icon(model)
        icons = YAML.load_file('config/icons.yml')
        icons['actions'][model.to_s]
      end

      def search_icon(title)
        tooltip = tooltip t('tooltips.search'), 'search', { class: 'minor' }
        "#{title} #{tooltip}".html_safe
      end
    end
  end
end
