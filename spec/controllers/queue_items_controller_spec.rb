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

  context "POST create authenticated" do
    before do
      @user = Fabricate(:user)
      session[:user_id] = @user.id
      @video = Fabricate(:video)
      post :create, video_id: @video.id
    end

    it "redirects to queue page" do
      expect(response).to redirect_to queue_path
    end

    it "creates a queue item" do
      expect(QueueItem.count).to eq(1)
    end

    it "creates a queue item associated with the video" do
      expect(QueueItem.first.video).to eq(@video)
    end

    it "creates a queue item associated with the signed in user" do
      expect(QueueItem.first.user).to eq(@user)
    end

    it "puts the video at bottom of queue" do
      video_bottom = Fabricate(:video)
      post :create, video_id: video_bottom.id
      video_bottom_queue_item = QueueItem.where(video_id: video_bottom, user_id: @user.id).first

      expect(video_bottom_queue_item.order).to eq(2)
    end

    it "does not allow video in queue multiple times" do
      video_dup = @video
      post :create, video_id: video_dup.id

      expect(@user.queue_items.count).to eq(1)
    end
  end

  context 'POST create unauthenticated' do
    it "redirects to sign in page for unauthenticated users" do
      post :create, video_id: 3

      expect(response).to redirect_to sign_in_path  
    end
  end

  context 'DELETE destroy authenticated' do
    before do
      @user = Fabricate(:user)
      session[:user_id] = @user.id
      @queue_item = Fabricate(:queue_item, user: @user)
      delete :destroy, id: @queue_item.id
    end

    it "redirects to the queue page" do
      expect(response).to redirect_to queue_path
    end

    it "deletes the queued item" do
      expect(QueueItem.count).to eq(0)
    end

    it "only deletes queued item if current user owns it" do
      x_user = Fabricate(:user)
      @queue_item = Fabricate(:queue_item, user: x_user)
      delete :destroy, id: @queue_item.id

      expect(QueueItem.count).to eq(1)
    end
  end

  context 'DELETE destroy unauthenticated' do
    it "redirects to sign in page for unauthenticated users" do
      # @queue_item = Fabricate(:queue_item)
      delete :destroy, id: 3

      expect(response).to redirect_to sign_in_path
    end
  end
end