# frozen_string_literal: true

module Toasts
  class ToastComponent < ViewComponent::Base
    private

    def icon_for(type)
      case type
      when 'success'
        'check'
      when 'error'
        'exclamation-triangle'
      else
        'info-circle'
      end
    end

    def bg_class_for(type)
      case type
      when 'success'
        'success'
      when 'error'
        'danger'
      else
        'info'
      end
    end

    def title_for(type)
      type.humanize
    end
  end
end
