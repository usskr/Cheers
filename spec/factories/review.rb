FactoryBot.define do
  factory :review do
    body { Faker::Lorem.characters(number: 30) }
    rate { 5 }
    user
    spot
  end
end
