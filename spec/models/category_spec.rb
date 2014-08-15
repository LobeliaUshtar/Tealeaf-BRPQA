require "spec_helper"

describe Category do
  it { should have_many(:videos) }

  describe "recent videos" do
    it "returns videos in reverse chronological order by created_at" do
      comedy =Category.create(name: "comedy")

      futurama = Video.create(title: "Futurama", description: "space", category: comedy, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "wierd", category: comedy)

      expect(comedy.recent_videos).to eq([south_park, futurama])
    end

    it "returns all the videos if there are less than 6" do
      comedy =Category.create(name: "comedy")

      futurama = Video.create(title: "Futurama", description: "space", category: comedy, created_at: 1.day.ago)
      south_park = Video.create(title: "South Park", description: "wierd", category: comedy)

      expect(comedy.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if more than 6 in category" do
      comedy =Category.create(name: "comedy")

      7.times {Video.create(title: "foobar", description: "raboof", category: comedy)}

      expect(comedy.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do
      comedy =Category.create(name: "comedy")

      6.times {Video.create(title: "foobar", description: "raboof", category: comedy)}
      the_tonight_show = Video.create(title: "the_tonight_show", description: "show", category: comedy, created_at: 1.day.ago)

      expect(comedy.recent_videos).not_to include(the_tonight_show)
    end

    it "returns an empty array if the category does not have any videos" do
      comedy =Category.create(name: "comedy")

      expect(comedy.recent_videos).to eq([])
    end
  end
end