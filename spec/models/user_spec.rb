require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'アソシエーション' do 
    it { is_expected.to have_many(:videos) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:like_videos) }

    describe 'validates' do
      let (:valid_user) { build(:user) }
      let (:other_user) { create(:user) }
      it 'ユーザーが作成完了する' do 
        user = User.new(
          first_name: 'name',
          last_name: 'test',
          email: 'rerson@example.com',
          password: '12345',
          password_confirmation: '12345'
        )
        expect(user.valid?).to be true
      end

      it '姓が未入力は失敗' do 
        valid_user.last_name = ' '
        expect(valid_user.valid?).to be false
      end

      it '姓が255字以上は失敗' do 
        valid_user.last_name = 'a' * 256
        expect(valid_user.valid?).to be false
      end


      it '名が未入力は失敗' do
        valid_user.first_name = ' '
        expect(valid_user.valid?).to be false
      end

      it '名が255字以上は失敗' do
        valid_user.first_name = 'a' * 256
        expect(valid_user.valid?).to be false
      end

    
      it 'メールアドレスが未入力は失敗' do
        valid_user.email = ' '
        expect(valid_user.valid?).to be false
      end

      it 'メールアドレスが重複している場合は失敗' do
        valid_user.email = other_user.email
        expect(valid_user.valid?).to be false
      end

      it 'パスワードが未入力は失敗' do 
        valid_user.password = ' '
        expect(valid_user.valid?).to be false
      end

      it 'パスワードが３文字以下は失敗' do
        valid_user.password = '11'
        valid_user.password_confirmation = '11'
        expect(valid_user.valid?).to be false
      end
    
      it 'パスワード確認が未入力は失敗' do 
        valid_user.password_confirmation = ' '
        expect(valid_user.valid?).to be false
      end
    end
  end
end

