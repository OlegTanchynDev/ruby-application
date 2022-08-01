# frozen_string_literal: true

class Service
  class SuccessfulResult < Result
    def initialize(values = {})
      @values = values
    end

    def successful?
      true
    end
  end
end
