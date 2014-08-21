require 'spec_helper'

describe QueueItem do
  it { should belong_to(:user) }
  it { should belong_to(:video) }

  context '#video_title' do
    it "returns the title of the associated video" do
      video = Fabricate(:video, title: 'Monk')
      queue_item = Fabricate(:queue_item, video: video)

      expect(queue_item.video_title).to eq('Monk')
    end
  end

  context '#rating' do
    before do
      @video = Fabricate(:video)
      @user = Fabricate(:user)
      @queue_item = Fabricate(:queue_item, user: @user, video: @video)
    end

    it "returns the review's rating if review present" do
      review = Fabricate(:review, user: @user, video: @video, rating: 4)

      expect(@queue_item.rating).to eq(4)
    end

    it "returns nil if review not present" do
      expect(@queue_item.rating).to eq(nil)
    end
  end

  context '#category_name' do
    before do
      @category = Fabricate(:category, name: 'comedy')
      @video = Fabricate(:video, category: @category)
      @queue_item = Fabricate(:queue_item, video: @video)
    end

    it "returns the category name of the video" do
      expect(@queue_item.category_name).to eq('comedy')
    end

    it "links to the category page" do
      expect(@queue_item.category).to eq(@category)
    end
  end
end