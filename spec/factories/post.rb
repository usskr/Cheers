FactoryBot.define do
  factory :post do
    category { '食事' }
    content { Faker::Lorem.characters(number: 30) }
    user
    start_time { 'Tue, 19 Oct 2021 00:00:00 JST +09:00' }
  end
end
