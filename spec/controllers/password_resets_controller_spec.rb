require 'spec_helper'

describe PasswordResetsController do
  context "GET show" do
    it "renders the show template if token is valid" do
      user = Fabricate(:user, token: '12345')
      user.update_column(:token, '12345')
      get :show, id: '12345'

      expect(response).to render_template :show
    end

    it "sets @token" do
      user = Fabricate(:user, token: '12345')
      user.update_column(:token, '12345')
      get :show, id: '12345'

      expect(assigns(:token)).to eq('12345')
    end

    it "redirects to the expired token page if the token is not valid" do
      get :show, id: '12345'

      expect(response).to redirect_to expired_token_path
    end
  end

  describe "POST create" do
    context 'with valid token' do
      it "redirects to the sign in page" do
        user = Fabricate(:user, token: '12345', password: 'old_password', password_confirmation: 'old_password')
        user.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password', password_confirmation: 'new_password'

        expect(response).to redirect_to sign_in_path
      end

      it "updates the user's password" do
        user = Fabricate(:user, token: '12345')
        user.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password', password_confirmation: 'new_password'

        expect(user.reload.authenticate('new_password')).to eq(true)
      end

      it "sets the flash success message" do
        user = Fabricate(:user, token: '12345', password: 'old_password', password_confirmation: 'old_password')
        user.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password', password_confirmation: 'new_password'

        expect(flash[:success]).to be_present
      end

      it "regenerates the user token" do
        user = Fabricate(:user, token: '12345', password: 'old_password', password_confirmation: 'old_password')
        user.update_column(:token, '12345')
        post :create, token: '12345', password: 'new_password', password_confirmation: 'new_password'

        expect(user.reload.token).not_to eq('12345')
      end
    end

    context 'with invalid token' do
      it "redirects to the expired token page" do
        post :create, token: '12345', password: 'new_password', password_confirmation: 'new_password'

        expect(response).to redirect_to expired_token_path
      end
    end
  end
end