require 'spec_helper'

feature "User resets password" do
  scenario "user successfully resets the password" do
    user = Fabricate(:user, password: 'old_password', password_confirmation: 'old_password')
    visit sign_in_path
    click_link "Forgot your password?"
    fill_in "Email Address", with: user.email
    click_button "Send Email"

    open_email(user.email)
    current_email.click_link("Reset My Password")

    fill_in "New Password", with: "new_password"
    fill_in "Confirm New Password", with: "new_password"
    click_button "Reset Password"

    fill_in "Email Address", with: user.email
    fill_in "Password", with: "new_password"
    click_button "Sign In"

    expect(page).to have_content("Welcome, #{user.full_name}")

    clear_email
  end
end