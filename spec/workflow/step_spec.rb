# frozen_string_literal: true

require 'spec_helper'
require_relative 'workflow_test'

RSpec.describe Workflow do
  describe Workflow::Step do
    describe 'validate_contract' do
      it 'implicitly validates contract of step (in Contract class) and fails operation' do
        result = WorkflowTest::Step.call names: 'test'

        expect(result).to be_failure
        expect(result.errors).to eq({ name: ['is missing'] })
      end
    end

    describe 'validate_result' do
      context 'if Result class is defined' do
        it 'implicitly validates result of step and fails operation' do
          allow_any_instance_of(WorkflowTest::Step).to receive(:assign_surname).and_return(nil)

          result = WorkflowTest::Step.call name: 'test'

          expect(result).to be_failure
          expect(result.errors).to eq({ surname: ['is missing'] })
        end
      end

      context 'if Result class is not defined' do
        it 'does not implicitly validate result of step' do
          allow(WorkflowTest::Step).to receive(:const_defined?).with('Result').and_return(false)
          allow_any_instance_of(WorkflowTest::Step).to receive(:assign_surname).and_return(nil)

          result = WorkflowTest::Step.call name: 'test'

          expect(result).to be_success
        end
      end
    end

    it 'delegates context to ctx' do
      operation = WorkflowTest::Step.call name: 'test'

      expect(operation.result.surname).to eq 'test'
    end
  end
end
