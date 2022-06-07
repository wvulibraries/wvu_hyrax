FactoryBot.define do
  factory :image do
    title { [Faker::Lorem.sentence] }
  end
end
