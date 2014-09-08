require 'spec_helper'

describe RelationshipsController do
  context "GET index" do
    it "sets @relationships to current user's followed people" do
      user = Fabricate(:user)
      set_current_user(user)
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
    it_behaves_like "requires sign in" do
      let(:action) { delete :destroy, id: 4 }
    end

    it "redirects back to the people page" do
      user = Fabricate(:user)
      set_current_user(user)
      user_x = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: user, leader: user_x)
      delete :destroy, id: relationship

      expect(response).to redirect_to people_path
    end

    it "deletes the relationship if the current user is the follower" do
      user = Fabricate(:user)
      set_current_user(user)
      user_x = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: user, leader: user_x)
      delete :destroy, id: relationship

      expect(Relationship.count).to eq(0)
    end

    it "does not delete the relationship if the current user is not the follower" do
      user = Fabricate(:user)
      set_current_user(user)
      user_x = Fabricate(:user)
      user_z = Fabricate(:user)
      relationship = Fabricate(:relationship, follower: user_z, leader: user_x)
      delete :destroy, id: relationship

      expect(Relationship.count).to eq(1)
    end
   end
end