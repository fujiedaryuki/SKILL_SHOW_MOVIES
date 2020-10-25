require 'rails_helper'

RSpec.describe 'コメント機能', type: :system  do 
  describe 'コメント表示' do 
    let(:user) { create(:user) } 
    let(:video) { create(:video, user_id: user.id) } 

    before { login_as(user) } 
    describe 'コメント投稿' do 
      context 'コメント投稿が正常' do
        it 'コメントが表示される', js: true do
          visit video_path(video)
          expect(page).to have_content "コメント"
          fill_in 'コメント', with: 'いい動画ですね！'
          click_button 'コメント投稿'
          expect(page).to have_content user.decorate.full_name 
          expect(page).to have_content "いい動画ですね！"
          expect(page).to have_selector '.fas.fa-trash-alt'
          expect(page).to have_selector "img[src$='/assets/user-eef95e143059ab63052df0d772768bbf3c7fa3bcfc97b34a63ada10baae19d6b.png']"
        end
      end
    end
    
    describe 'コメント削除' do 
      before { login_as(user) } 
      context '自分が投稿を削除' do
        it '削除が成功' do 
          visit video_path(video)
          fill_in 'コメント', with: 'いい動画ですね！'
          click_button 'コメント投稿'
          find('.fas.fa-trash-alt').click
          expect(page.accept_confirm).to eq "コメントを削除しますか？？？？"
          expect(current_path).to eq video_path(video)
        end
      end
    end
  end
end

