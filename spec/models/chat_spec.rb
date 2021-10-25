# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Chatモデルのテスト', type: :model do
  describe '保存テスト' do
    it '有効な場合は保存されるか' do
      expect(FactoryBot.build(:chat)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    subject { chat.valid? }

    let(:user) { create(:user) }
    let(:room) { create(:room) }
    let!(:chat) { build(:chat, user_id: user.id, room_id: room.id) }

    context 'messageカラム' do
      it '空欄でないこと' do
        chat.message = ''
        is_expected.to eq false
      end
      it '100文字以下であること: 100文字は〇' do
        chat.message = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it '100文字以下であること: 101文字は×' do
        chat.message = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end
end
