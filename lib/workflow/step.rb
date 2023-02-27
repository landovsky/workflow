# frozen_string_literal: true

module Workflow
  class Step
    class ContractValidator < Workflow::Step; end

    include Interactor
    include Workflow::SchemaValidation

    def self.inherited(subclass)
      subclass.before do
        validate_contract
      end
      subclass.after do
        validate_result
      end
      super
    end

    def fail!(message)
      context.fail! errors: message
    end
  end
end
