# frozen_string_literal: true

require 'bundler/setup'
require 'dry-validation'
require 'interactor'

# TODOS
# - Workflow: when contract validation fails, it's unclear in which step it was
# - step could allow an entity to be passed in as a model or an id

require_relative 'workflow/schema_validation'
require_relative 'workflow/step'
require_relative 'workflow/operation'
require_relative 'workflow/operation_result'
require_relative 'validation_types'
require_relative 'interactor_context_extension'
require_relative 'interactor_monkey_patch'

# Workflow is a library for building complex business logic in a declarative way.
# It wraps the Interactor gem and adds a couple of few features:
# - validate step contracts (.validate_contract)
# - validate step results (.validate_result)
# - validate operation contracts (Workflow::Step::ValidateContract())
# - .on_success, .on_failure yields the resulting context into a block

module Workflow; end
