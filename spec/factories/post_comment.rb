FactoryBot.define do
  factory :post_comment do
    comment { Faker::Lorem.characters(number: 30) }
    user
    post
  end
end
