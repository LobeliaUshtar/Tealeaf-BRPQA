require 'spec_helper'

feature "User invites a friend" do
  scenario "user successfully invites a friend and invitation is accepted" do
    user = Fabricate(:user)
    sign_in(user)

    invite_a_friend
    friend_accepts_invitation
    friend_signs_in

    friend_should_follow(user)
    inviter_should_follow_friend(user)

    clear_email
  end

  def invite_a_friend
    visit new_invitation_path
    fill_in "Friend's Name", with: "Ex Ample"
    fill_in "Friend's Email Address", with: "ex@example.com"
    fill_in "Message", with: "blahblahblahblah"
    click_button "Send Invitation"
    sign_out
  end

  def friend_accepts_invitation
    open_email "ex@example.com"
    current_email.click_link "Accept this invitation"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    fill_in "Full Name", with: "Ex Ample"
    click_button "Sign Up"
  end

  def friend_signs_in
    fill_in "Email Address", with: "ex@example.com"
    fill_in "Password", with: "password"
    click_button "Sign In"
  end

  def friend_should_follow(user)
    click_link "People"
    expect(page).to have_content(user.full_name)
    sign_out
  end

  def inviter_should_follow_friend(inviter)
    sign_in(inviter)
    click_link "People"
    expect(page).to have_content("Ex Ample")
  end
end