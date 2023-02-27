# frozen_string_literal: true

module Workflow
  class OperationResult
    def result
      @result ||= {}
    end

    def to_h
      result
    end

    def freeze!
      @result = result.freeze
    end

    def method_missing(method, *args, &block)
      if method.to_s.end_with?('=')
        result[method.to_s.gsub('=', '').to_sym] = args.first
      else
        result.fetch(method)
      end
    rescue KeyError, FrozenError
      super
    end
  end
end
