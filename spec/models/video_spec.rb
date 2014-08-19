require "spec_helper"

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  context "search by title" do
    it "returns an empty array if there is no match" do
      dragnet = Video.create(title: "Dragnet", description: "cops", created_at: 1.day.ago)
      maverick = Video.create(title: "Maverick", description: "western")

      expect(Video.search_by_title("hello")).to eq( [] )
    end

    it "returns an array of one video for an exact match" do
      dragnet = Video.create(title: "Dragnet", description: "cops", created_at: 1.day.ago)
      maverick = Video.create(title: "Maverick", description: "western")
      
      expect(Video.search_by_title("Dragnet")).to eq([dragnet])
    end

    it "returns an array of one video for a partial match" do
      dragnet = Video.create(title: "Dragnet", description: "cops", created_at: 1.day.ago)
      maverick = Video.create(title: "Maverick", description: "western")

      expect(Video.search_by_title("veri")).to eq([maverick])
    end

    it "returns an array of all matches ordered by created_at" do
      dragnet = Video.create(title: "Dragnet", description: "cops", created_at: 1.day.ago)
      maverick = Video.create(title: "Maverick", description: "western")

      expect(Video.search_by_title("e")).to eq([maverick, dragnet])
    end

    it "returns an empty array for a search with an empty string" do
      dragnet = Video.create(title: "Dragnet", description: "cops", created_at: 1.day.ago)
      maverick = Video.create(title: "Maverick", description: "western")

      expect(Video.search_by_title("")).to eq([])
    end
  end
end