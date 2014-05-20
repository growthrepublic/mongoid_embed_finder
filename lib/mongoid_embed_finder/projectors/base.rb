module MongoidEmbedFinder
  module Projectors
    class Base < Struct.new(:query, :relation)
      def projection
        { relation.key => { operator => query.child_criteria.selector }}
      end

      def project(fields = [])
        projection_with_fields = projection.merge(include_fields(fields))
        query.scope_parent(projection)
        query.execute.select(projection_with_fields)
      end

      def operator
        raise NotImplementedError, "operator needs to be overriden"
      end

      private

      def include_fields(fields)
        fields.inject({}) do
          |acc, name| acc.merge(name => 1)
        end
      end
    end
  end
end