require "spec_helper"

describe "A category" do
  it { should have_many(:videos) }
end