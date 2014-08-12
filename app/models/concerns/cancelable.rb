module Cancelable
  extend ActiveSupport::Concern

  included do
    define_model_callbacks :cancel
  end

  def cancel
    run_callbacks(:cancel) do
      update_attribute :is_canceled, true
    end
  end
end
