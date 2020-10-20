require 'rails_helper'

RSpec.describe 'Vidoe', type: :system do
  let(:user) { create(:user) }
  let(:video) { create(:video) }

  describe 'ログイン前' do 
    describe 'ページ遷移確認' do
      context '動画投稿一覧ページにアクセス' do 
        it '動画投稿一覧ページアクセス失敗' do 
          visit videos_path 
          expect(page).to have_content "ログインが必要です"
          expect(current_path).to eq login_path
        end
      end
    
      context '動画作成ページにアクセス' do 
        it '動画作成ページにアクセスが失敗' do
          visit new_video_path
          expect(page).to have_content "ログインが必要です"
          expect(current_path).to eq login_path
        end
      end
    end
  end

  describe 'ログイン後' do 
    before { login_as(user) }

    describe '動画作成' do 
      context 'フォームの入力値が正常' do 
        it '動画作成が成功' do 
          visit new_video_path
          fill_in '動画タイトル', with: 'test_title'
          fill_in '詳細',  with: 'test_body'
          click_button '登録'
          expect(page).to have_content "投稿動画作成"
          expect(current_path).to eq '/videos'
        end
      end

      context 'フォームの入力値が異常' do 
        it '動画タイトルが未入力' do 
          visit new_video_path
          fill_in '動画タイトル', with: ' '
          fill_in '詳細',  with: 'test_body'
          click_button '登録'
          expect(page).to have_content "投稿動画作成が失敗しました"
          expect(page).to have_content "動画タイトルを入力してください"
          expect(current_path).to eq '/videos'
        end
      end
    end

    describe '投稿動画編集' do
      let!(:video) { create(:video, user: user) }

      context 'フォームの入力値が正常' do 
        it '動画編集が成功する' do
          visit edit_video_path(video) 
          fill_in '動画タイトル', with: 'updated_title'
          fill_in '詳細',  with: 'tupdated_body'
          click_button '更新する'
          expect(page).to have_content "更新しました"
          expect(current_path).to eq video_path(video)
        end
      end

      context '動画タイトルが未入力' do 
        it '動画編集が失敗する' do 
          visit edit_video_path(video) 
          fill_in '動画タイトル', with: '　'
          fill_in '詳細',  with: 'tupdated_body'
          click_button '更新する'
          expect(page).to have_content "更新に失敗"
          expect(page).to have_content "動画タイトルを入力してください"
          expect(current_path).to eq video_path(video) 
        end
      end
    end

    describe '投稿動画削除' do 
      let!(:video) { create(:video, user: user) }
      it '投稿動画削除が成功する' do
        visit videos_path
        click_link '削除'
        expect(page.accept_confirm).to eq '削除してよろしいですか？'
        expect(page).to have_content "削除しました"
        expect(current_path).to eq '/videos'
        expect(page).not_to have_content video.title
      end
    end
  end
end