# frozen_string_literal: true

module Utilities
  module TooltipHelper
    attr_reader :tooltip_title, :tooltip_icon, :tooltip_options

    def tooltip(tooltip_title, tooltip_icon = 'question-circle-o', tooltip_options = {})
      @tooltip_title = tooltip_title
      @tooltip_icon = tooltip_icon
      @tooltip_options = tooltip_options

      construct_tooltip
    end

    private

    def construct_tooltip
      tooltip_options ||= { class: nil, placement: :top }

      fa_icon(
        tooltip_icon,
        title: tooltip_title,
        class: tooltip_options[:class],
        data: {
          bs_target: :tooltip,
          bs_placement: tooltip_options[:placement]
        }
      )
    end
  end
end
