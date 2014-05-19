require "spec_helper"
require "mongoid_embed_finder/projectors/base"

describe MongoidEmbedFinder::Projectors::Base do
  describe "#projection" do
    let(:relation) { double(key: "children") }
    let(:criteria) { double(selector: { "name" => "Child Name 0" }) }

    subject { described_class.new(relation, criteria) }

    it "relies on methods to be implemented" do
      expect { subject.projection }.to raise_error(NotImplementedError)
    end
  end
end