FactoryBot.define do
  factory :collection do
    depositor { Faker::Internet.email }
    title { [Faker::Lorem.sentence] }
    collection_type_gid { "gid://wvu-hyrax/Hyrax::CollectionType/1" } # normally auto generated on save of collection
    description { [Faker::Lorem.paragraph] }
  end
end
