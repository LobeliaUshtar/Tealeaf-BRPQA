require 'spec_helper'

describe RelationshipsController do
  context "GET index" do
    let(:user) { Fabricate(:user) }

    before do
      set_current_user(user)
    end

    it "sets @relationships to current user's followed people" do
      user_x = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: user, leader: user_x)
      get :index

      expect(assigns(:relationships)).to eq([relationship])
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :index }
    end
  end

  context 'DELETE destroy' do
    let(:user) { Fabricate(:user) }

    before do
      set_current_user(user)
    end

    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 4 }
    end

    it "redirects back to the people page" do
      user_x = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: user, leader: user_x)
      delete :destroy, id: relationship

      expect(response).to redirect_to people_path
    end

    it "deletes the relationship if the current user is the follower" do
      user_x = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: user, leader: user_x)
      delete :destroy, id: relationship

      expect(Relationship.count).to eq(0)
    end

    it "does not delete the relationship if the current user is not the follower" do
      user_x = Fabricate(:user)
      user_z = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: user_z, leader: user_x)
      delete :destroy, id: relationship

      expect(Relationship.count).to eq(1)
    end
  end

  context 'POST create' do
    let(:user) { Fabricate(:user) }

    before do
      set_current_user(user)
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :create, leader_id: 3 }
    end

    it "redirects back to the people page" do
      user = Fabricate(:user)
      set_current_user(user)
      user_x = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: user, leader: user_x)
      delete :destroy, id: relationship

      expect(response).to redirect_to people_path
    end

    it "creates a relationship that the current user follows the leader" do
      user_x = Fabricate(:user)
      post :create, leader_id: user_x.id

      expect(user.following_relationships.first.leader).to eq(user_x)
    end

    it "does not create a relationship if the current user already follows the leader" do
      user_x = Fabricate(:user)
      Fabricate(:relationship, leader: user_x, follower: user)
      post :create, leader_id: user_x.id

      expect(Relationship.count).to eq(1)
    end

    it "does not allow user to follow themself" do
      post :create, leader_id: user.id

      expect(Relationship.count).to eq(0)
    end
  end

end