FactoryBot.define do
  factory :audio do
    title { [Faker::Lorem.sentence] }
  end
end
