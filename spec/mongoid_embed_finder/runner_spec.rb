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
        result = subject.first(
          id: cars[1].doors[1].id.to_s,
          parent: { id: cars[1].id.to_s })

        expect(result).to eq cars[1].doors[1]
      end

      context "not listed parent's attributes" do
        it "sets only id" do
          result = subject.first(
            id: cars[1].doors[1].id.to_s,
            parent: { id: cars[1].id.to_s })

          expect(result.car.id).to eq cars[1].id
          expect(result.car.name).to be_nil
        end
      end

      context "listed parent's attributes" do
        it "sets listed attributes" do
          result = subject.first(
            id: cars[1].doors[1].id.to_s,
            parent: { id: cars[1].id.to_s, include_fields: [:name] })

          expect(result.car.id).to eq cars[1].id
          expect(result.car.name).to eq cars[1].name
        end
      end
    end

    context "no parent attributes" do
      it "returns the child" do
        result = subject.first(id: cars[1].doors[1].id.to_s)
        expect(result).to eq cars[1].doors[1]
      end

      context "not listed parent's attributes" do
        it "sets only id" do
          result = subject.first(id: cars[1].doors[1].id.to_s)
          expect(result.car.id).to eq cars[1].id
          expect(result.car.name).to be_nil
        end
      end

      context "listed parent's attributes" do
        it "sets listed attributes" do
          result = subject.first(id: cars[1].doors[1].id.to_s,
            parent: { include_fields: [:name] })

          expect(result.car.id).to eq cars[1].id
          expect(result.car.name).to eq cars[1].name
        end
      end
    end

    context "child does not exist" do
      let(:wrong_id) { "5369f2d8417274e9d8000000" }

      it "returns nil" do
        expect(subject.first(id: wrong_id)).to be_nil
      end
    end
  end
end