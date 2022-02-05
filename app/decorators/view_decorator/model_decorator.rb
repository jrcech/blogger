# frozen_string_literal: true

module ViewDecorator
  module ModelDecorator
    def model_string
      model.to_s
    end

    alias model_singular model_string

    def model_singular_symbol
      model_singular.underscore.to_sym
    end

    def model_singular_titleize
      model_singular.titleize
    end

    def model_plural
      model_string.pluralize
    end

    def model_plural_symbol
      model_plural.underscore.to_sym
    end

    def model_nested?
      params.keys.any? { |key| key.to_s.match(/_id/) }
    end

    def model_parent
      request.path[%r{/([a-z_]+)/\d+}, 1].singularize if model_nested?
    end

    def model_parent_id
      request.path[%r{/[a-z_]+/(\d+)}, 1]
    end

    private

    def model
      case @resources
      when ApplicationRecord
        @resources.class
      when ActiveRecord::Relation
        @resources.name.safe_constantize
      else
        controller_name.classify.safe_constantize
      end
    end
  end
end
