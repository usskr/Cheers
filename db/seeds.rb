# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "demo", email: "user@demo.com", password: "111111", profile_image: open("./app/assets/images/icon1.jpeg"), introduction: "1日30分のランニングを目標に頑張っています！現在2ヶ月目！", is_valid: true)
User.create!(name: "tnk0202", email: "user2@demo.com", password: "222222", profile_image: open("./app/assets/images/icon2.JPG"), introduction: "これまでの食生活を猛省し、減塩にトライしています。減塩レシピのレパートリーを増やしたい！！", is_valid: true)
User.create!(name: "3ymdy", email: "user3@demo.com", password: "333333", profile_image: open("./app/assets/images/icon3.JPG"), introduction: "今年中に5kg痩せるために食生活改善＆ジム通い中。", is_valid: true)
User.create!(name: "satoto", email: "user4@demo.com", password: "444444", profile_image: open("./app/assets/images/icon4.jpeg"), introduction: "最近は早朝テニスにハマっています！都内でいいコートがあれば教えていただきたいです！", is_valid: true)
User.create!(name: "chikamochi", email: "user5@demo.com", password: "555555", profile_image: open("./app/assets/images/icon5.jpeg"), introduction: "趣味は筋トレ。仕事前にジムに行ってトレーニングすることが日課です。", is_valid: true)