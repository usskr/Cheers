# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe '保存テスト' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end
  
  describe 'バリデーションのテスト' do
    subject { post.valid? }

    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    context 'categoryカラム' do
      it '空欄でないこと' do
        post.category = ''
        is_expected.to eq false
      end
    end

    context 'contentカラム' do
      it '空欄でないこと' do
        post.content = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        post.content = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        post.content = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end
end
