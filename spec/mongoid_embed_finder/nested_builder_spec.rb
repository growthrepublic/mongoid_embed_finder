require "spec_helper"
require "mongoid_embed_finder/nested_builder"

describe MongoidEmbedFinder::NestedBuilder do
  let(:relations) do
    double(
      parent_class: Car,
      child_class: Door,
      children: double(key: "doors"),
      parent: double(key: "car", setter: "car=")
    )
  end

  context "parent with children" do
    let(:nested_attrs) do
      {
        "_id" => "parent_id",
        "name" => "Car Name",
        "doors" => 2.times.map do |n|
          {
            "_id" => "child_id_#{n}",
            "name" => "Child Name #{n}",
          }
        end
      }
    end

    describe "#build_child" do
      subject { described_class.new(nested_attrs, relations).build_child }

      its(:_id) { should eq "child_id_0" }
      its(:name) { should eq "Child Name 0" }
      its('car._id') { should eq "parent_id" }
      its('car.name') { should eq "Car Name" }
    end

    describe "#build_parent" do
      subject { described_class.new(nested_attrs, relations).build_parent }

      its(:_id) { should eq "parent_id" }
      its(:name) { should eq "Car Name" }
      its(:doors) { should be_empty }
    end
  end

  context "parent without children" do
    let(:nested_attrs) do
      {
        "_id" => "parent_id",
        "name" => "Car Name",
        "doors" => []
      }
    end

    describe "#build_child" do
      subject { described_class.new(nested_attrs, relations).build_child }
      it { should be_nil }
    end

    describe "#build_parent" do
      subject { described_class.new(nested_attrs, relations).build_parent }

      its(:_id) { should eq "parent_id" }
      its(:name) { should eq "Car Name" }
      its(:doors) { should be_empty }
    end
  end
end