require "spec_helper"

describe User do
  it { should have_secure_password }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
  it { should have_many(:queue_items).order("position") }
  it { should have_many(:reviews).order("created_at DESC") }
  it "generates a random token when the user is created" do
    user = Fabricate(:user)

    expect(user.token).to be_present
  end

  context '#queued_video?' do
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }

    it "returns true if user queued the video" do
      queue_item = Fabricate(:queue_item, user: user, video: video)

      expect(user.queued_video?(video)).to eq(true)
    end

    it "returns true if user queued the video" do
      expect(user.queued_video?(video)).to eq(false)
    end
  end

  context '#follows?' do
    it "returns true if user does follow another user" do
      user = Fabricate(:user)
      user_x = Fabricate(:user)
      Fabricate(:relationship, leader: user_x, follower: user)

      expect(user.follows?(user_x)).to eq(true)
    end

    it "returns false if user does not follow another user" do
      user = Fabricate(:user)
      user_x = Fabricate(:user)
      Fabricate(:relationship, leader: user, follower: user_x)

      expect(user.follows?(user_x)).to_not eq(true)
    end
  end
end