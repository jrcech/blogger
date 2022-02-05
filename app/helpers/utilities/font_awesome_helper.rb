# frozen_string_literal: true

module Utilities
  module FontAwesomeHelper
    attr_reader :options, :icon

    def fa_icon(icon, options = {})
      @options = options
      @icon = icon

      "<i class='#{construct_class}'#{construct_data}#{construct_title}></i>#{text}".html_safe
    end

    def construct_data
      return nil if options[:data].blank?

      construct_data_string
    end

    def construct_data_string
      data = +''
      options[:data].each do |key, value|
        data << "data-#{key.to_s.dasherize}='#{value}'"
      end

      data
    end

    def construct_title
      title = options[:title]
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

    private

    def construct_class
      "#{style}#{construct_icon}#{size}#{fixed_width}" +
        + "#{animation}#{rotation}#{border}#{pull}"
    end

    def text
      text = options[:text]
      return " <span>#{text}</span>" if text.present?

      nil
    end

    def style
      style = options[:style]
      return style if style.present?

      'fas'
    end

    def construct_icon
      " fa-#{icon}"
    end

    def size
      size = options[:size]
      return " fa-#{size}" if size.present?

      nil
    end

    def animation
      animation = options[:animation]
      return " fa-#{animation}" if animation.present?

      nil
    end

    def fixed_width
      return ' fa-fw' if options[:fixed_width].present?

      nil
    end

    def rotation
      rotation = options[:rotation]
      return " fa-#{rotation}" if rotation.present?

      nil
    end

    def border
      return ' fa-border' if options[:border].present?

      nil
    end

    def pull
      position = options[:pull]
      return " fa-pull-#{position}" if position.present?

      nil
    end
  end
end
