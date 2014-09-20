require 'spec_helper'

describe InvitationsController do
  context 'GET new' do
    it "sets @invitation to a new invitation" do
      set_current_user
      get :new

      expect(assigns(:invitation)).to be_new_record
      expect(assigns(:invitation)).to be_instance_of Invitation
    end

    it_behaves_like "requires sign in" do
      let(:action) { get :new }
    end
  end

  describe 'POST create' do
    it_behaves_like "requires sign in" do
      let(:action) { post :create }
    end

    context 'with valid input' do
      before do
        set_current_user
        post :create, invitation: {recipient_name: "Ex Ample", recipient_email: "ex@example.com", message: "blah blah blah"}
      end
      
      after { ActionMailer::Base.deliveries.clear }

      it "redirects to the invitation page" do
        expect(response).to redirect_to new_invitation_path
      end

      it "creates an invitation" do
        expect(Invitation.count).to eq(1)
      end

      it "sends an email to the recipient" do
        expect(ActionMailer::Base.deliveries.last.to).to eq(['ex@example.com'])
      end

      it "sets the success flash message" do
        expect(flash[:success]).to be_present
      end
    end

    context 'with invalid input' do
      before do
        set_current_user
        post :create, invitation: {recipient_email: "ex@example.com", message: "blah blah blah"}
      end

      before { ActionMailer::Base.deliveries.clear }
      after {ActionMailer::Base.deliveries.clear}

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "does not create an invitation" do
        expect(Invitation.count).to eq(0)
      end

      it "does not send an email to the recipient" do
        expect(ActionMailer::Base.deliveries).to be_empty
      end

      it "sets the error flash message" do
        expect(flash[:danger]).to be_present
      end

      it "sets @invitation" do
        expect(assigns(:invitation)).to be_present
      end
    end
  end
end