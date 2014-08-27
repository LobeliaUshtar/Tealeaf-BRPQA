require 'spec_helper'

feature "user signs in" do
  scenario "with valid email and password" do
    user = Fabricate(:user)
    visit sign_in_path
    fill_in "Email Address", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"

    expect(page).to   have_content user.full_name
  end
end