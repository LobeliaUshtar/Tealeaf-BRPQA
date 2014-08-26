require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  it { should validate_numericality_of(:position).only_integer }

  context '#video_title' do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: 'Monk')
      queue_item = Fabricate(:queue_item, video: video)

      expect(queue_item.video_title).to eq('Monk')
    end
  end

  context '#rating' do
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, user: user, video: video) }

    it "returns the review's rating if review present" do
      review = Fabricate(:review, user: user, video: video, rating: 4)

      expect(queue_item.rating).to eq(4)
    end

    it "returns nil if review not present" do
      expect(queue_item.rating).to eq(nil)
    end
  end

  context '#rating=' do
    let(:video) { Fabricate(:video) }
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, user: user, video: video) }

    it "changes the rating of the review if review present" do
      review = Fabricate(:review, user: user, video: video, rating: 2)
      queue_item.rating = 4

      expect(Review.first.rating).to eq(4)
    end

    it "clears the rating of the review if review present" do
      review = Fabricate(:review, user: user, video: video, rating: 2)
      queue_item.rating = nil

      expect(Review.first.rating).to be_nil
    end

    it "create a review with the rating if no review present" do
      queue_item.rating = 3

      expect(Review.first.rating).to eq(3)
    end
  end

  context '#category_name' do
    let(:category) {  Fabricate(:category, name: 'comedy')}
    let(:video) { Fabricate(:video, category: category) }
    let(:queue_item) { Fabricate(:queue_item, video: video) }

    it "returns the category name of the video" do
      expect(queue_item.category_name).to eq('comedy')
    end

    it "links to the category page" do
      expect(queue_item.category).to eq(category)
    end
  end
end