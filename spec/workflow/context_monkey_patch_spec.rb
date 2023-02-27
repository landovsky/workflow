# frozen_string_literal: true

require 'spec_helper'
require_relative 'workflow_test'

RSpec.describe InteractorContextExtension do
  describe 'monkey patch' do
    describe 'on_success' do
      it 'yields the resulting Interactor::Context into block' do
        result = WorkflowTest::Step.call name: 'Smith'

        result.on_success do |ctx|
          expect(ctx.result.surname).to eq 'Smith'
        end
      end
    end

    describe 'on_failure' do
      it 'yields the resulting Interactor::Context into block' do
        result = WorkflowTest::Step.call name: 'fail'

        result.on_failure do |ctx|
          expect(ctx.errors).to eq({ name: ['some error'] })
        end
      end
    end
  end
end
