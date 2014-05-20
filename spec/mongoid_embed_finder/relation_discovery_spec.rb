require "spec_helper"
require "mongoid_embed_finder/relation_discovery"

describe MongoidEmbedFinder::RelationDiscovery do
  describe "#relations" do
    subject { described_class.new(Door, :car).relations }

    its(:child_class)  { should eq Door }
    its(:parent_class) { should eq Car }

    its('children.key')        { should eq "doors" }
    its('children.class_name') { should eq "Door" }

    its('parent.setter') { should eq "car=" }
  end
end