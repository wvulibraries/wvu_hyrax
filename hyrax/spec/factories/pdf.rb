FactoryBot.define do
  factory :pdf do
    title { [Faker::Lorem.sentence] }
  end
end
