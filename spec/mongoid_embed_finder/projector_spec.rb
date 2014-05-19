require "spec_helper"
require "mongoid_embed_finder/projector"

describe MongoidEmbedFinder::Projector do
  describe "#to_projection" do
    let(:relation) { double(key: "children") }
    let(:criteria) { double(selector: { "name" => "Child Name 0" }) }

    subject { described_class.new(relation, criteria) }

    it "needs to be implemented in derived classes" do
      expect { subject.to_projection }.to raise_error(NotImplementedError)
    end
  end
end