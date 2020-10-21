require 'rails_helper'

RSpec.describe 'Profile', type: :system  do 

  describe 'ログイン前' do
    describe 'ページ移行確認' do
      context 'プロフィールにアクセス' do 
        it 'プロフィールにアクセス失敗' do 
          visit profile_path
          expect(page).to have_content 'ログインが必要です'
          expect(current_path).to eq login_path
        end
      end
      
      context '編集ページにアクセス' do 
        it '編集ページにアクセス失敗' do 
          visit edit_profile_path
          expect(page).to have_content "ログインが必要です"
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'ログイン後' do 
    before { login_as(user) } 
    let(:user) { create(:user) }

    describe 'ページ移行確認' do
      context 'プロフィールにアクセス' do
        it 'プロフィールが表示されている' do
          visit profile_path
          expect(page).to have_content 'メールアドレス'
          expect(page).to have_content 'ユーザー'
          expect(page).to have_content 'アバター'
          expect(page).to have_selector "img[src$='/assets/user-eef95e143059ab63052df0d772768bbf3c7fa3bcfc97b34a63ada10baae19d6b.png']"
          expect(page).to have_content user.email
          expect(page).to have_content 'test test'
          expect(page).to have_content "編集"
        end
      end

      context 'プロフィール編集ページアクセス' do 
        it 'プロフィール編集が表示されている' do
          visit edit_profile_path
          fill_in 'メールアドレス', with: user.email
          fill_in '姓', with: user.first_name
          fill_in '名', with: user.last_name
          expect(page).to have_selector "img[src$='/assets/user-eef95e143059ab63052df0d772768bbf3c7fa3bcfc97b34a63ada10baae19d6b.png']"
          click_button '更新'
        end
      end
    end

    describe 'プロフィール編集' do

      context 'メールアドレスを編集' do 
        it 'メールアドレスが変更が成功' do
          visit edit_profile_path 
          fill_in 'メールアドレス', with: 'test@expettt'
          fill_in '姓', with: user.first_name
          fill_in '名', with: user.last_name
          expect(page).to have_selector "img[src$='/assets/user-eef95e143059ab63052df0d772768bbf3c7fa3bcfc97b34a63ada10baae19d6b.png']"
          click_button '更新'
          expect(page).to have_content "プロフィールを更新しました！"
          expect(current_path).to eq '/profile'
        end

        it '画像の変更が成功する' do  
          visit edit_profile_path 
          fill_in 'メールアドレス', with: user.email
          fill_in '姓', with: user.first_name
          fill_in '名', with: user.last_name
          attach_file 'アバター', "#{Rails.root}/app/assets/images/log.png"
          click_button '更新'
          expect(page).to have_content "プロフィールを更新しました！"
          expect(current_path).to eq '/profile'
        end
      end

      context 'メールアドレスが未入力' do
        it 'メールアドレスが変更が失敗' do
          visit edit_profile_path 
          fill_in 'メールアドレス', with: '  '
          fill_in '姓', with: user.first_name
          fill_in '名', with: user.last_name
          expect(page).to have_selector "img[src$='/assets/user-eef95e143059ab63052df0d772768bbf3c7fa3bcfc97b34a63ada10baae19d6b.png']"
          click_button '更新'
          expect(page).to have_content "プロフィールの更新に失敗"
          expect(page).to have_content "メールアドレスを入力してください"
          expect(current_path).to eq '/profile'
        end
      end
    end
  end
end

