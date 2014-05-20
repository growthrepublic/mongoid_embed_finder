require "spec_helper"
require "mongoid_embed_finder/projectors/base"

describe MongoidEmbedFinder::Projectors::Base do
  describe "#projection" do
    let(:query) do
      double(
        scope_parent: nil,
        execute: double(select: []),
        child_criteria: double(selector: {}))
    end
    let(:relation) { double(key: "children") }

    subject { described_class.new(query, relation) }

    it "relies on methods to be implemented" do
      expect { subject.projection }.to raise_error(NotImplementedError)
    end
  end
end