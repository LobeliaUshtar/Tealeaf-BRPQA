require 'spec_helper'

describe VideosController do
  context 'GET show authenticated' do
    let(:video) { Fabricate(:video) }

    before do
      session[:user_id] = Fabricate(:user).id
      get :show, id: video.id
    end
    it "sets @video" do
      expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews" do
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)

      expect(assigns(:reviews)).to match_array([review1, review2])
    end
  end

  context 'GET show unauthenticated' do
    it "redirects to the sign in page for unauthenticated users" do
      video = Fabricate(:video)
      get :show, id: video.id

      expect(response).to redirect_to sign_in_path
    end
  end

  context 'POST search' do
    it "sets @results for authenticated users" do
      session[:user_id] = Fabricate(:user).id
      futurama = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'

      expect(assigns(:results)).to eq([futurama])
    end

    it "redirects to the sign in page for unauthenticated users" do
      futurama = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'

      expect(response).to redirect_to sign_in_path
    end
  end

end