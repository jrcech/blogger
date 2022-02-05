# frozen_string_literal: true

module ViewDecorator
  include ViewDecorator::ControllerDecorator
  include ViewDecorator::ModelDecorator
  include ViewDecorator::PathDecorator
  include ViewDecorator::ResourceDecorator
end
