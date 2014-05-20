require "mongoid_embed_finder/nested_query"
require "mongoid_embed_finder/nested_builder"
require "mongoid_embed_finder/projectors/single"
require "mongoid_embed_finder/relation_discovery"

module MongoidEmbedFinder
  class Runner
    def initialize(child_class, parent_relation_name)
      @relation_discovery = RelationDiscovery.new(
        child_class, parent_relation_name)
    end

    def first(parent: {}, **attrs)
      nested_attrs = find_first(attrs, parent: parent)
      return nil unless nested_attrs
      build_child_with_parent(nested_attrs)
    end

    private

    def find_first(attrs = {}, parent: {})
      query = build_nested_query(attrs, parent: parent)
      project_query(query, Projectors::Single,
        parent_fields: parent.fetch(:include_fields, [])).first
    end

    def build_nested_query(attrs = {}, parent: {})
      parent_criteria = relations.parent_class.criteria
      child_criteria  = relations.child_class.criteria

      NestedQuery.new(parent_criteria, child_criteria).tap do |query|
        query.scope_parent(parent.except(:include_fields))
        query.scope_child(attrs)
      end
    end

    def project_query(query, projector_class, parent_fields: [])
      projector_class.new(query, relations.children).project(parent_fields)
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