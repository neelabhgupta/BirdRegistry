FactoryGirl.define do
  factory :birds do
    name { Faker::Lorem.sentence }
  end
end