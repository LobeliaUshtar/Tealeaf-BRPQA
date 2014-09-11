require 'spec_helper'

describe ForgotPasswordsController do
  describe 'POST create' do
    context 'with blank inputs' do
      before do
        post :create, email: ''
      end

      it "redirects to the forgot password page" do
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do
        expect(flash[:danger]).to eq("Email Address cannot be blank.")
      end
    end

    context 'with existing email' do
      before do
        Fabricate(:user, email: "ex@example.com")
        post :create, email: 'ex@example.com'
      end

      it "redirects to the forgot password confirmation page" do
        expect(response).to redirect_to forgot_password_confirmation_path
      end

      it "sends out an email to the email address" do
        expect(ActionMailer::Base.deliveries.last.to).to eq(['ex@example.com'])
      end
    end

    context 'with non-existing email' do
      before do
        post :create, email: 'xe@example.com'
      end
      it "redirects to the forgot password page" do
        expect(response).to redirect_to forgot_password_path
      end

      it "shows an error message" do
        expect(flash[:danger]).to eq("There is no user with this email in the system.")
      end
    end
  end
end