require "spec_helper"
require "mongoid_embed_finder/runner"

describe MongoidEmbedFinder::Runner do
  subject { described_class.new(Door, :car) }

  describe "#first" do
    let!(:cars) do
      2.times.map do |n|
        Car.create(name: "Parent Name #{n}").tap do |car|
          2.times.map do |n|
            car.doors << Door.new(name: "Child Name #{n}")
          end
        end
      end
    end

    context "by child_id and parent_id" do
      it "returns the child" do
        door = subject.first(
          id: cars[1].doors[1].id.to_s,
          parent: { id: cars[1].id.to_s })

        expect(door).to eq cars[1].doors[1]
      end
    end

    context "no parent attributes" do
      it "returns the child" do
        door = subject.first(id: cars[1].doors[1].id.to_s)
        expect(door).to eq cars[1].doors[1]
      end
    end
  end
end