require "mongoid_embed_finder/projectors/base"

module MongoidEmbedFinder
  module Projectors
    class Single < Base
      def operator
        "$elemMatch"
      end
    end
  end
end