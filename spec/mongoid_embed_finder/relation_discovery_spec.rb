require "spec_helper"
require "mongoid_embed_finder/relation_discovery"

describe MongoidEmbedFinder::RelationDiscovery do
  describe "#relations" do
    subject { described_class.new(Child, :parent).relations }

    its(:child_class)  { should eq Child }
    its(:parent_class) { should eq Parent }

    its('children.key')        { should eq "children" }
    its('children.class_name') { should eq "Child" }

    its('parent.setter') { should eq "parent=" }
  end
end