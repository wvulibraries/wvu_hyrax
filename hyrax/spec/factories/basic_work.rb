FactoryBot.define do
    factory :basic_work do
      title { ["Work"] }
      access_control
      skip_create
      override_new_record
    end
  end