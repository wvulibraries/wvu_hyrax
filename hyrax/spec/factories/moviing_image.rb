FactoryBot.define do
  factory :moving_image do
    title { [Faker::Lorem.sentence] }
  end
end
