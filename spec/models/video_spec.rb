require "spec_helper"

describe "A video" do
  it "saves itself" do
    video = Video.new(title: 'Monk', description: 'blah', small_cover: '/tmp/monk.jpg', large_cover: '/tmp/monk_large.jpg', category_id: 3)
    video.save

    expect(Video.first).to eq(video)
  end

  it "belongs to a category" do
    mystery = Category.create(name: "mystery")
    monk = Video.create(title: 'Monk', description: 'blah', category_id: 1)

    expect(monk.category).to eq(mystery)
  end

  it "does not save video without title" do
    video = Video.create(description: 'blah')

    expect(Video.count).to eq(0)
  end

  it "does not save a video without description" do
    video = Video.create(title: 'Monk')

    expect(Video.count).to eq(0)
  end
end