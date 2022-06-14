FactoryBot.define do
  factory :collection do
    depositor { Faker::Internet.email }
    title { [Faker::Lorem.sentence] }
    description { [Faker::Lorem.paragraph] }

    factory :user_collection do
      collection_type_gid { "gid://wvu-hyrax/Hyrax::CollectionType/1" } # User Collection
    end

    factory :user_collection do
      collection_type_gid { "gid://wvu-hyrax/Hyrax::CollectionType/2" } # Admin Set
    end    
  end
end
