module MongoidEmbedFinder
  class NestedBuilder
    def initialize(nested_attrs, relations)
      @nested_attrs = nested_attrs
      @relations = relations
    end

    def build_child
      return nil if children_attributes.empty?

      @relations.child_class.new(children_attributes.first).tap do |child|
        child.public_send(@relations.parent.setter, build_parent)
      end
    end

    def build_parent
      @relations.parent_class.new(parent_attributes)
    end

    def children_attributes
      @children_attributes ||= @nested_attrs.fetch(@relations.children.key)
    end

    def parent_attributes
      @parent_attributes ||= @nested_attrs.except(@relations.children.key)
    end
  end
end