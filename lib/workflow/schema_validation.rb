# frozen_string_literal: true

module Workflow
  module SchemaValidation
    module ClassMethods
      # contract params dsl
      def contract(&block)
        Class.new(Dry::Validation::Contract, &block)
      end
    end

    def self.included(base)
      base.extend ClassMethods
    end

    private

    def validate_contract
      schema = self.class::Contract

      result = schema.new.call(context.to_h)

      if result.errors.any?
        context.fail!(errors: result.errors.to_h)
      else
        result.to_h.each do |key, val|
          context[key] ||= val
        end
      end
    end

    def validate_result
      return unless self.class.const_defined?('Result')

      separate_result

      schema = self.class::Result

      validation = schema.new.call(context.result.to_h)

      if validation.errors.any?
        context.result = nil
        context.fail!(errors: validation.errors.to_h)
      end
    rescue Interactor::Failure
      rollback if defined?(rollback)
      raise
    end

    def separate_result
      context.result ||= Workflow::OperationResult.new

      result_keys = self.class::Result.params.types.keys
      result_keys.each do |key|
        context.result.send "#{key}=".to_sym, context[key] if context[key]
      end
    end

    def ctx
      context
    end
  end
end
