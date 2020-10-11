require 'rails_helper'

RSpec.describe 'User', type: :system do
  let(:user) { create(:user) }
  describe 'ログイン前' do 
    describe 'ユーザー新規登録' do
      context 'フォーム入力値が正常' do
        it 'ユーザーの新規登録が成功' do
          visit new_user_path
          fill_in '姓', with: 'てすと'
          fill_in '名', with: 'てすと'
          fill_in 'メールアドレス', with: 'a@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(current_path).to eq login_path
        end
      end

      context 'メールアドレスが未入力' do 
        it 'ユーザー登録が失敗' do
          visit new_user_path
          fill_in '姓', with: 'てすと'
          fill_in '名', with: 'てすと'
          fill_in 'メールアドレス', with: ' '
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content "メールアドレスを入力してください"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(current_path).to eq '/users'
        end
      end

      context '登録済メールアドレス使用' do 
        it 'ユーザー新規登録が失敗' do
          existed_user = create(:user)
          visit new_user_path
          fill_in '姓', with: 'てすと'
          fill_in '名', with: 'てすと'
          fill_in 'メールアドレス', with: existed_user.email
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content "メールアドレスはすでに存在します"
          expect(page).to have_content "ユーザー登録に失敗しました"
          expect(current_path).to eq '/users'
        end
      end
    end

    describe 'ログインページ' do 
      context 'フォーム入力値が正常' do 
        it 'ログイン成功' do 
          visit login_path
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: 'password'
          click_button 'ログイン'
          expect(page).to have_content "ログインしました"
          expect(current_path).to eq '/videos'
        end
      end

      context 'メールアドレルが未入力' do 
        it 'ログイン失敗' do 
          visit login_path
          fill_in 'メールアドレス', with: ''
          fill_in 'パスワード', with: 'password'
          click_button 'ログイン'
          expect(page).to have_content "ログインに失敗"
          expect(current_path).to eq login_path
        end
      end
    end

    describe 'プロフィール' do 
      context 'ログインしてない状態' do
        it 'プロフィールにアクセス失敗' do 
          visit edit_profile_path
          expect(page).to have_content "ログインが必要です"
          expect(current_path).to eq login_path
        end
      end
    end
  end    
end



