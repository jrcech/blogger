# frozen_string_literal: true

module Utilities
  module ColorsHelper
    attr_reader :button

    def bootstrap_class
      {
        new: 'success',
        edit: 'primary',
        destroy: 'danger',
        make_admin: 'secondary',
        make_member: 'warning'
      }[button[:action]]
    end
  end
end
