# frozen_string_literal: true

class Service
  class Result
    def initialize(hash)
    end

    def values
      {}
    end

    def error
      {}
    end

    def successful?
      false
    end
    alias success? successful?

    def failed?
      false
    end
    alias failure? failed?
  end
end
