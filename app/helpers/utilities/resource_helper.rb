# frozen_string_literal: true

module Utilities
  module ResourceHelper
    extend ActiveSupport::Concern

    def model_controller_same?
      return true if model_plural_symbol == controller_plural_symbol

      false
    end

    def resource_namespaced?
      return true if model_nested? || controller_namespaced?

      false
    end

    def resource_namespace
      namespace = ''
      namespace += "#{controller_namespace}_" if controller_namespaced?
      namespace += "#{model_parent}_" if model_nested?

      namespace
    end
  end
end
