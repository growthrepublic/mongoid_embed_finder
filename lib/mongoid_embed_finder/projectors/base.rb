module MongoidEmbedFinder
  module Projectors
    class Base < Struct.new(:query, :relation)
      def projection
        { relation.key => { operator => query.child_criteria.selector }}
      end

      def project
        query.scope_parent(projection)
        query.execute.select(projection)
      end

      def operator
        raise NotImplementedError, "operator needs to be overriden"
      end
    end
  end
end