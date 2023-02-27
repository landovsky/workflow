# frozen_string_literal: true

module InteractorContextExtension
  def on_success
    yield(self) if success?
  end

  def on_failure
    yield(self) if failure?
  end
end
