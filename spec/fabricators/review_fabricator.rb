Fabricator(:review) do
  rating { (1..5).to_a.sample }
  comment { Faker::Lorem.paragraph(3) }
end