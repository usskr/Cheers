# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PostCommentモデルのテスト', type: :model do
  describe '保存テスト' do
    it '有効なコメントの場合は保存されるか' do
      expect(FactoryBot.build(:post_comment)).to be_valid
    end
  end

  describe 'バリデーションのテスト' do
    subject { post_comment.valid? }

    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let!(:post_comment) { build(:post_comment, user_id: user.id, post_id: post.id) }

    context 'commentカラム' do
      it '空欄でないこと' do
        post_comment.comment = ''
        is_expected.to eq false
      end
      it '100文字以下であること: 100文字は〇' do
        post_comment.comment = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it '100文字以下であること: 101文字は×' do
        post_comment.comment = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end
  end
end
