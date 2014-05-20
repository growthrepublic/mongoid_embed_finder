module MongoidEmbedFinder
  class NestedQuery
    attr_reader :parent_criteria, :child_criteria

    def initialize(parent_criteria, child_criteria)
      @parent_criteria = parent_criteria
      @child_criteria  = child_criteria
    end

    def scope_parent(conditions = {})
      @parent_criteria = @parent_criteria.where(conditions)
    end

    def scope_child(conditions = {})
      @child_criteria = @child_criteria.where(conditions)
    end

    def execute
      parent_criteria.collection
        .find(parent_criteria.selector)
    end
  end
end