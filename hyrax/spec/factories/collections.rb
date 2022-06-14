FactoryBot.define do
  factory :collection do
    depositor { Faker::Internet.email }
    title { [Faker::Lorem.sentence] }
    description { [Faker::Lorem.paragraph] }
    collection_type_gid { "gid://wvu-hyrax/Hyrax::CollectionType/1" } # User Collection

    factory :admin_set do
      collection_type_gid { "gid://wvu-hyrax/Hyrax::CollectionType/2" } # Admin Set
    end    
  end
end