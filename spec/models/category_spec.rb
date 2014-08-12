require "spec_helper"

describe "A category" do
  it "saves itself" do
    category = Category.new(name: 'mysteries')
    category.save

    expect(Category.first).to eq(category)
  end

  it "has many videos" do
    comedies = Category.create(name: 'comedies')
      futurama = Video.create(title:"Futurama", description: 'space', category: comedies)
      monk = Video.create(title: 'Monk', description: 'detective', category: comedies)

      expect(comedies.videos).to eq([futurama, monk])
  end
end