# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reviewモデルのテスト', type: :model do
  describe '保存テスト' do
    it '有効な場合は保存されるか' do
      expect(FactoryBot.build(:review)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    subject { review.valid? }

    let(:user) { create(:user) }
    let(:spot) { create(:spot) }
    let!(:review) { build(:review, user_id: user.id, spot_id: spot.id) }

    context 'bodyカラム' do
      it '空欄でないこと' do
        review.body = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        review.body = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        review.body = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end

    context 'rateカラム' do
      it '空欄でないこと' do
        review.rate = ''
        is_expected.to eq false
      end
    end
  end
end
