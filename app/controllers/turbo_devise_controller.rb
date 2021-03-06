# frozen_string_literal: true

class TurboDeviseController < ApplicationController
  class Responder < ActionController::Responder
    def to_turbo_stream
      controller.render(options.merge(formats: :html))
    rescue ActionView::MissingTemplate => e
      return raise e if get?

      if has_errors? && default_action
        return render rendering_options.merge(
          formats: :html,
          status: :unprocessable_entity
        )
      end

      redirect_to navigation_location
    end
  end

  self.responder = Responder

  respond_to :html, :turbo_stream
end
