require "spec_helper"

describe "A user" do
  it "saves itself" do
    user = User.new(email: "dummy@example.com", password: "dummy", password_confirmation: "dummy", full_name: "dummy")
    user.save

    expect(User.first).to eq(user)
  end
end