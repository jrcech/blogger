# frozen_string_literal: true

module ControllerHelper
  def controller_singular
    controller_name.singularize
  end

  def controller_singular_symbol
    controller_name.singularize.underscore.to_sym
  end

  def controller_plural
    controller_name
  end

  def controller_plural_symbol
    controller_name.underscore.to_sym
  end

  def controller_namespace
    return controller_path.split('/').first if controller_namespaced?

    nil
  end

  def controller_namespaced?
    controller_name != controller_path
  end
end
