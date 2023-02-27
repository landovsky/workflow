# frozen_string_literal: true

require 'spec_helper'
require_relative 'workflow_test'

RSpec.describe Workflow::Operation do
  specify 'resulting context is yielded into block' do
    WorkflowTest::Operation.call(name: 'Doe') do |operation|
      expect(operation.result.surname).to eq 'Doe'
    end
  end

  describe 'validate_contract' do
    it 'implicitly validates contract of operation (in Contract class) and fails operation' do
      result = WorkflowTest::Operation.call names: 'test'

      expect(result).to be_failure
      expect(result.errors).to eq({ name: ['is missing'] })
    end
  end

  describe 'validate_result' do
    context 'if Result class is defined' do
      it 'implicitly validates result of operation and fails operation' do
        allow_any_instance_of(WorkflowTest::Step).to receive(:assign_surname).and_return(nil)

        result = WorkflowTest::Operation.call name: 'test'

        expect(result).to be_failure
        expect(result.errors).to eq({ surname: ['is missing'] })
      end

      it 'separates result from context' do
        operation = WorkflowTest::Operation.call name: 'test'

        expect(operation.result).to be_a Workflow::OperationResult
        expect(operation.result.surname).to eq 'test'
      end

      it 'does not allow to modify result', skip: 'not implemented' do
        operation = WorkflowTest::Step.call name: 'test'

        expect { operation.result.surname = 'test2' }.to raise_error NoMethodError
      end

      context 'when result validation fails' do
        specify 'result is nil' do
          allow_any_instance_of(WorkflowTest::Step).to receive(:assign_surname).and_return(nil)

          operation = WorkflowTest::Operation.call name: 'test'

          expect(operation.result).to be_nil
        end
      end
    end

    context 'if Result class is not defined' do
      it 'does not implicitly validate result of operation' do
        allow(WorkflowTest::Step).to receive(:const_defined?).with('Result').and_return(false)
        allow(WorkflowTest::Operation).to receive(:const_defined?).with('Result').and_return(false)
        allow_any_instance_of(WorkflowTest::Step).to receive(:assign_surname).and_return(nil)

        result = WorkflowTest::Operation.call name: 'test'

        expect(result).to be_success
      end
    end
  end
end
