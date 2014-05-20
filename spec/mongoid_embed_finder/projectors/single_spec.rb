require "spec_helper"
require "mongoid_embed_finder/projectors/single"

describe MongoidEmbedFinder::Projectors::Single do
  let(:relation) { double(key: "children") }
  let(:criteria) { double(selector: { "name" => "Child Name 0" }) }
  let(:projection_result) { [] }
  let(:query) do
    double(
      scope_parent: nil,
      execute: double(select: projection_result),
      child_criteria: criteria)
  end

  subject { described_class.new(query, relation) }

  describe "#projection" do
    its(:projection) { should eq(relation.key => { "$elemMatch" => criteria.selector }) }
  end

  describe "#project" do
    it "extend parent's criteria" do
      subject.project
      expect(query).to have_received(:scope_parent).with(subject.projection)
    end

    it "projects query" do
      subject.project
      expect(query).to have_received(:execute)
      expect(query.execute).to have_received(:select).with(subject.projection)
    end

    it "returns projection result" do
      expect(subject.project).to eq projection_result
    end
  end
end