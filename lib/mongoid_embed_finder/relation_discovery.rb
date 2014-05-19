require "ostruct"
require "active_support/inflector"

module MongoidEmbedFinder
  class RelationDiscovery < Struct.new(:child_class, :relation_name)
    def relations
      @relations ||= OpenStruct.new(
        child_class:  child_class,
        parent_class: parent_class,
        children:     find_children_relation,
        parent:       find_parent_relation)
    end

    private

    def find_parent_relation
      @parent_relation ||= child_class.relations.fetch(relation_name.to_s)
    end

    def parent_class
      @parent_class ||= find_parent_relation.class_name.constantize
    end

    def find_children_relation
      @children_relation ||= parent_class.relations.values
        .find { |v| v.class_name == child_class.name }
    end
  end
end