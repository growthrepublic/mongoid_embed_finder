module MongoidEmbedFinder
  module Projectors
    class Base < Struct.new(:relation, :criteria)
      def projection
        { relation.key => { operator => criteria.selector }}
      end

      def operator
        raise NotImplementedError, "operator needs to be overriden"
      end
    end
  end
end