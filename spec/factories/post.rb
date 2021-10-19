FactoryBot.define do
  factory :post do
    category { '食事' }
    content { Faker::Lorem.characters(number: 30) }
    user
  end
end
