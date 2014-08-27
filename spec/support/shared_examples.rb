shared_examples "requires sign in" do
  it "redirects to the sign in page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to sign_in_path
  end
end

=begin
it_behaves_like "requires sign in" do
  let(:action) {  }
end
=end