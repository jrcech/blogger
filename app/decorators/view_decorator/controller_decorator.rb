# frozen_string_literal: true

module ViewDecorator
  module ControllerDecorator
    def controller_singular
      controller_name.singularize
    end

    def controller_singular_symbol
      controller_singular.underscore.to_sym
    end

    def controller_plural
      controller_name
    end

    def controller_plural_symbol
      controller_plural.underscore.to_sym
    end

    def controller_namespaced?
      return true if controller_name != controller_path

      false
    end

    def controller_namespace
      return controller_path.split('/').first if controller_namespaced?

      nil
    end
  end
end
