require "spec_helper"

describe "A user" do
  it { should have_secure_password }

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should validate_uniqueness_of(:email) }
end