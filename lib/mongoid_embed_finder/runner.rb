require "mongoid_embed_finder/projectors/base"
require "mongoid_embed_finder/projectors/single"
require "mongoid_embed_finder/nested_builder"
require "mongoid_embed_finder/relation_discovery"

module MongoidEmbedFinder
  class Runner
    def initialize(child_class, parent_relation_name)
      @relation_discovery = RelationDiscovery.new(
        child_class, parent_relation_name)
    end

    def first(parent: {}, **attrs)
      nested_attrs = find_first(attrs, parent: parent)
      build_child_with_parent(nested_attrs)
    end

    private

    def find_first(attrs = {}, parent: {})
      scope_parent(parent)
      project(attrs, with: Projectors::Single)
      execute_query.first
    end

    def scope_parent(attrs = {})
      @parent_criteria ||= relations.parent_class.criteria
      @parent_criteria.selector.merge!(attrs)
    end

    def project(attrs = {}, with: Projectors::Base)
      child_criteria  = relations.child_class.criteria.where(attrs)
      @projector = with.new(relations.children, child_criteria)
      scope_parent(@projector.projection)
    end

    def execute_query
      relations.parent_class.collection
        .find(@parent_criteria.selector)
        .select(@projector.projection)
    end

    def build_child_with_parent(nested_attrs)
      builder = NestedBuilder.new(nested_attrs, relations)
      builder.build_child
    end

    def relations
      @relation_discovery.relations
    end
  end
end