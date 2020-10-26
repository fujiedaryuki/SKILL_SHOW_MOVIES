require 'rails_helper'

RSpec.describe Video, type: :model do

  describe 'アソシエーション' do 
    it { is_expected.to have_many(:likes) }

    describe 'validates' do
      let(:user) { create (:user) }
      let(:valid_video) { create(:video, user_id: user.id) }
      context '正常系' do
        it '動画投稿' do
          video = Video.new(
          user_id: user.id,
          title: '動画タイトル',
          body: '動画詳細'
          ) 
          expect(video.valid?).to be true
        end
      end

      context '異常系' do 
        it '動画タイトルが未入力は失敗' do
          valid_video.title = ' '
          expect(valid_video.valid?).to be false
        end

        it '動画タイトルが255字以上は失敗' do
          valid_video.title = 'a' * 256
          expect(valid_video.valid?).to be false
        end

        it '動画詳細が未入力は失敗' do
          valid_video.body = ' '
          expect(valid_video.valid?).to be false
        end

        it '動画詳細が65535字以上は失敗' do
          valid_video.body = 'a' * 65536
          expect(valid_video.valid?).to be false
        end
      end
    end
  end
end