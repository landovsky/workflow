# frozen_string_literal: true

module Workflow
  class Operation
    include Interactor::Organizer
    include Workflow::SchemaValidation

    def self.inherited(subclass)
      subclass.before { validate_contract }
      subclass.after { validate_result }
      super
    end

    def result
      context.result ||= Workflow::OperationResult.new
    end

    def self.call(**options)
      block_given? ? yield(super(**options)) : super(**options)
    end
  end
end
