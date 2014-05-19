require "spec_helper"
require "mongoid_embed_finder/projectors/single"

describe MongoidEmbedFinder::Projectors::Single do
  describe "#projection" do
    let(:relation) { double(key: "children") }
    let(:criteria) { double(selector: { "name" => "Child Name 0" }) }

    subject { described_class.new(relation, criteria) }

    its(:projection) { should eq(relation.key => { "$elemMatch" => criteria.selector }) }
  end
end