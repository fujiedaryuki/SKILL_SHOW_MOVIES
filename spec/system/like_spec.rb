require 'rails_helper'

RSpec.describe 'いいね機能', type: :system  do 
  let(:user) { create(:user)} 
  let(:other_user) { create(:user)} 
  let!(:video) { create(:video, user_id: other_user.id) }  
  let!(:video) { create(:video, user_id: user.id) }  
  let(:video) { create(:video, user_id: other_user.id) }  

  describe '動画一覧ページ' do
    before { login_as(user) }

    context 'いいねしていない場合、いいねができること', js: true do
      it 'いいねボタンの色が変わる' do
        find('.far.fa-thumbs-up').click
        expect(page).to have_selector '.fas.fa-thumbs-up'
      end
    end

    context '削除' do 
      it 'いいねされてる場合、いいねを外せるか', js: true do
        within '.card-body' do
          find('.far.fa-thumbs-up').click
          find('.fas.fa-thumbs-up').click
          expect(page).to have_selector '.far.fa-thumbs-up'
        end
      end
    end
  end

  describe 'いいねページ' do
    before { login_as(user) }

    context 'いいねした場合' do 
      it 'いいねページに表示されているか', js: true do
        find('.far.fa-thumbs-up').click
        visit likes_videos_path
        expect(Video.count).to eq 1
        expect(current_path).to eq likes_videos_path
      end
    end

    context 'いいねを外した場合' do 
      it 'いいねページから削除されているか' do
        find('.far.fa-thumbs-up').click
        visit likes_videos_path
        within '.card-body' do 
          find('.fas.fa-thumbs-up').click
        end
        visit videos_path
        visit likes_videos_path
        expect(page).not_to have_content video.title
        expect(current_path).to eq likes_videos_path
      end
    end 
  end
end
