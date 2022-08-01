# frozen_string_literal: true

class Service
  class FailedResult < Result
    def initialize(error = {})
      @error = error
    end

    def failed?
      true
    end
  end
end
