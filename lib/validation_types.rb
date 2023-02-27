# frozen_string_literal: true

module Types
  include Dry.Types()

  def self.collection(model_class)
    Instance(model_class.const_get(:ActiveRecord_Relation)) |
      Instance(model_class.const_get(:ActiveRecord_Associations_CollectionProxy)) |
      Instance(model_class.const_get(:ActiveRecord_AssociationRelation)) |
      Array.of(Instance(model_class))
  end
end
