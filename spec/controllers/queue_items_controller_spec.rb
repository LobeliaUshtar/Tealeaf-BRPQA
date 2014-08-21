require 'spec_helper'

describe QueueItemsController do
  context "GET index" do
    it "sets @queue_items to the queued items of the signed in user" do
      gabby = Fabricate(:user)
      session[:user_id] = gabby.id
      queue_item1 = Fabricate(:queue_item, user: gabby)
      queue_item2 = Fabricate(:queue_item, user: gabby)
      get :index

      expect(assigns(:queue_items)).to match_array([queue_item1, queue_item2])
    end

    it "redirect to the sign in page for unauthenticated users" do
      get :index

      expect(response).to redirect_to sign_in_path
    end
  end
end