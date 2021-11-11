# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  describe '保存テスト' do
    it '有効なユーザ情報の場合は保存されるか' do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context 'nameカラム' do
      it '空欄でないこと' do
        user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        user.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '10文字以下であること: 10文字は〇' do
        user.name = Faker::Lorem.characters(number: 10)
        is_expected.to eq true
      end
      it '10文字以下であること: 11文字は×' do
        user.name = Faker::Lorem.characters(number: 11)
        is_expected.to eq false
      end
      it '一意性があること' do
        user.name = other_user.name
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        user.email = ''
        is_expected.to eq false
      end
      it '255文字以下であること: 255文字は〇' do
        user.email = "a" * 243 + "@example.com"
        is_expected.to eq true
      end
      it '255文字以下であること: 256文字は×' do
        user.email = "a" * 244 + "@example.com"
        is_expected.to eq false
      end
      it '一意性があること' do
        user.email = other_user.email
        is_expected.to eq false
      end
      it "小文字化されていること" do
        user.email = "HOGE@example.com"
        user.save
        expect(user[:email]).to eq("hoge@example.com")
      end
      it "フォーマットの検証（有効な場合）" do
        emails = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn)
        emails.each do |email|
          user.email = email
          is_expected.to eq true
        end
      end
      it "フォーマットの検証（有効でない場合）" do
        emails = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com)
        emails.each do |email|
          user.email = email
          is_expected.to eq false
        end
      end
    end

    context 'introductionカラム' do
      it '100文字以下であること: 100文字は〇' do
        user.introduction = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it '100文字以下であること: 101文字は×' do
        user.introduction = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end
end
