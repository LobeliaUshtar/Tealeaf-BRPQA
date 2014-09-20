require 'spec_helper'

describe UsersController do
  context 'GET new' do
    it "sets @user" do
      get :new

      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context 'with valid input (no tokens)' do
      before do
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end
    end

    context 'with valid input (tokens)' do
      before do
        @user = Fabricate(:user)
        @invitation = Fabricate(:invitation, inviter: @user, recipient_email: 'ex@example.com')
        post :create, user: {email: 'ex@example.com', password: 'password', password_confirmation: 'password', full_name: 'Ex Ample'}, invitation_token: @invitation.token
        @ex = User.where(email: 'ex@example.com').first
      end

      it "makes the user follow the inviter" do
        expect(@ex.follows?(@user)).to eq(true)
      end

      it "makes the inviter follow the user" do
        expect(@user.follows?(@ex)).to eq(true)
      end

      it "expires the token upon acceptance" do
        expect(Invitation.first.token).to be_nil
      end
    end

    context 'with invalid input' do
      before do
        post :create, user: { email: "user@example.com",  full_name: "user" }
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "render the :new template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

    context 'sending emails' do
      before { ActionMailer::Base.deliveries.clear }
      after { ActionMailer::Base.deliveries.clear }

      it "sends out email to the user with valid inputs" do
        post :create, user: {email: "ex@example.com", password: "password", password_confirmation: "password", full_name: "Ex Ample"}
        expect(ActionMailer::Base.deliveries.last.to).to eq(['ex@example.com'])
      end

      it "sends out email containing the user's name with vaild inputs" do
        post :create, user: {email: "ex@example.com", password: "password", password_confirmation: "password", full_name: "Ex Ample"}
        expect(ActionMailer::Base.deliveries.last.body).to include('Ex Ample')
      end

      it "does not send out email with invalid inputs" do
        post :create, user: {email: "ex@example.com"}
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  context "GET show" do
    it_behaves_like "requires sign in" do
      let(:action) { get :show, id: 3 }
    end

    it "sets @user" do
      set_current_user
      user = Fabricate(:user)
      get :show, id: user.id

      expect(assigns(:user)).to eq(user)
    end
  end

  context 'GET new_with_invitation_token with valid tokens' do
    before do
      @invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: @invitation.token
    end

    it "renders the :new view template" do
      expect(response).to render_template :new
    end

    it "sets @user with recipient's email" do
      expect(assigns(:user).email).to eq(@invitation.recipient_email)
    end

    it "sets @invitation_token" do
      expect(assigns(:invitation_token)).to eq(@invitation.token)
    end
  end

  context 'GET new_with_invitation_token with invalid tokens' do
    before do
      get :new_with_invitation_token, token: 'vzbfiosdyb'
    end

    it "redirects to expired token page" do
      expect(response).to redirect_to expired_token_path
    end
  end
end