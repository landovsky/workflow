# frozen_string_literal: true

module WorkflowTest
  class Step < Workflow::Step
    Contract = contract do
      params do
        required(:name).value(Types::String)
      end
    end

    Result = contract do
      params do
        required(:surname).value(Types::String)
      end
    end

    before do
      # ctx.fail! errors: { name: ['some error'] } if ctx.name == 'fail'
      fail!({ name: ['some error'] }) if ctx.name == 'fail'
    end

    def call
      assign_surname
    end

    def assign_surname
      ctx.surname = ctx.name
    end
  end

  class Operation < Workflow::Operation
    Contract = contract do
      params do
        required(:name).value(Types::String)
      end
    end

    Result = contract do
      params do
        required(:surname).value(Types::String)
      end
    end

    organize WorkflowTest::Step
  end
end
