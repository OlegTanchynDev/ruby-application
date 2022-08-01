# frozen_string_literal: true

class Service
  def initialize(*args, **kwargs)
  end

  def self.call(*args, **kwargs)
    self.new(*args, **kwargs).call
  end

  def call
  end

  def success(values = {})
    SuccessfulResult.new(values)
  end

  def failure(error = {})
    FailedResult.new(error)
  end
end
