require "spec_helper"

describe User do
  it { should have_secure_password }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order("position") }

  context '#queued_video?' do
    it "returns true if user queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)
      queue_item = Fabricate(:queue_item, user: user, video: video)

      expect(user.queued_video?(video)).to eq(true)
    end

    it "returns ture if user queued the video" do
      user = Fabricate(:user)
      video = Fabricate(:video)

      expect(user.queued_video?(video)).to eq(false)
    end
  end
end