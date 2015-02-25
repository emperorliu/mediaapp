Fabricator(:media_item) do
  title { Faker::Lorem.word }
  medium { Faker::Lorem.word }
  description { Faker::Lorem.paragraph(3) }

end