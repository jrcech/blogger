# frozen_string_literal: true

module Elements
  module Buttons
    module Dropdown
      module Presets
        private

        def ellipsis_button
          {
            class: 'btn btn-light',
            icon: 'ellipsis-v'
          }
        end

        def test_button
          {
            class: 'btn btn-secondary',
            icon: 'check'
          }
        end
      end
    end
  end
end
