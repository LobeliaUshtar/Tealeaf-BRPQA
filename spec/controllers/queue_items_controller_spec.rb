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
    let(:user) { Fabricate(:user) }
    let(:video) { Fabricate(:video) }

    before do
      session[:user_id] = user.id
      post :create, video_id: video.id
    end

    it "redirects to queue page" do
      expect(response).to redirect_to queue_path
    end

    it "creates a queue item" do
      expect(QueueItem.count).to eq(1)
    end

    it "creates a queue item associated with the video" do
      expect(QueueItem.first.video).to eq(video)
    end

    it "creates a queue item associated with the signed in user" do
      expect(QueueItem.first.user).to eq(user)
    end

    it "puts the video at bottom of queue" do
      video_bottom = Fabricate(:video)
      post :create, video_id: video_bottom.id
      video_bottom_queue_item = QueueItem.where(video_id: video_bottom, user_id: user.id).first

      expect(video_bottom_queue_item.position).to eq(2)
    end

    it "does not allow video in queue multiple times" do
      video_dup = video
      post :create, video_id: video_dup.id

      expect(user.queue_items.count).to eq(1)
    end
  end

  context 'POST create unauthenticated' do
    it "redirects to sign in page for unauthenticated users" do
      post :create, video_id: 3

      expect(response).to redirect_to sign_in_path  
    end
  end

  context 'DELETE destroy authenticated' do
    let(:user) { Fabricate(:user) }
    let(:queue_item) { Fabricate(:queue_item, user: user) }

    before do
      session[:user_id] = user.id
      delete :destroy, id: queue_item.id
    end

    it "redirects to the queue page" do
      expect(response).to redirect_to queue_path
    end

    it "deletes the queued item" do
      expect(QueueItem.count).to eq(0)
    end

    it "normalizes the remaining queue items" do
      queue_item1 = Fabricate(:queue_item, user: user, position: 1)
      queue_item2 = Fabricate(:queue_item, user: user, position: 2)
      delete :destroy, id: queue_item1.id

      expect(QueueItem.first.position).to eq(1)
    end

    it "only deletes queued item if current user owns it" do
      x_user = Fabricate(:user)
      queue_item = Fabricate(:queue_item, user: x_user)
      delete :destroy, id: queue_item.id

      expect(QueueItem.count).to eq(1)
    end
  end

  context 'DELETE destroy unauthenticated' do
    it "redirects to sign in page for unauthenticated users" do
      delete :destroy, id: 3

      expect(response).to redirect_to sign_in_path
    end
  end

  describe 'POST update' do
    context 'with valid inputs' do
      let(:user) { Fabricate(:user) }
      let(:video) { Fabricate(:video) }
      let(:queue_item1) { Fabricate(:queue_item, user: user, video: video, position: 1) }
      let(:queue_item2) { Fabricate(:queue_item, user: user, video: video, position: 2) }

      before do
        session[:user_id] = user.id
        post :update, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
      end

      it "redirects to the queue page" do
        expect(response).to redirect_to queue_path  
      end

      it "reorders the queue" do
        expect(user.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        post :update, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]

        expect(user.queue_items.map(&:position)).to  eq([1, 2])
      end
    end

    context 'with invalid inputs' do
      before do
        @user = Fabricate(:user)
        @video = Fabricate(:video)
        session[:user_id] = @user.id
        @queue_item1 = Fabricate(:queue_item, user: @user, video: @video, position: 1)
        @queue_item2 = Fabricate(:queue_item, user: @user, video: @video, position: 2)
        post :update, queue_items: [{id: @queue_item1.id, position: 3.4}, {id: @queue_item2.id, position: 1}]
      end

      it "redirects to the queue page" do
        expect(response).to redirect_to queue_path  
      end

      it "sets the flash error message" do
        expect(flash[:danger]).to  be_present
      end

      it "does not change the queue items" do
        post :update, queue_items: [{id: @queue_item1.id, position: 3}, {id: @queue_item2.id, position: 1.5}]

        expect(@queue_item1.reload.position).to eq(1)
      end
    end

    context 'with unauthenticated users' do
      it "redirects to the sign in page" do
        post :update, queue_items: [{id: 3, position: 2}, {id: 5, position: 2}]

        expect(response).to redirect_to sign_in_path  
      end
    end

    context 'with queue items that do not belong to the current user' do
      it "does not change the queue items" do
        user_a = Fabricate(:user)
        user_z = Fabricate(:user)
        video = Fabricate(:video)
        session[:user_id] = user_a.id
        queue_item1 = Fabricate(:queue_item, user: user_z, video: video, position: 1)
        queue_item2 = Fabricate(:queue_item, user: user_a, video: video, position: 2)
        post :update, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]

        expect(queue_item1.reload.position).to  eq(1)
      end
    end
  end

end