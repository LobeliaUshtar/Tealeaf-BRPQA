require 'spec_helper'

describe VideosController do
  context 'GET show' do
    let(:video) { Fabricate(:video) }

    before do
      set_current_user
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

    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: video.id }
    end
  end

  context 'POST search' do
    before do
      set_current_user
    end

    it "sets @results" do
      futurama = Fabricate(:video, title: 'Futurama')
      post :search, search_term: 'rama'

      expect(assigns(:results)).to eq([futurama])
    end

    it_behaves_like "requires sign in" do
      let(:action) { post :search, search_term: 'rama' }
    end
  end

end