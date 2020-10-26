require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'validates' do
    let(:user) { create(:user) }
    let(:video) { create(:video, user_id: user.id) }
    context '正常系' do
      it 'いいねが生成される' do
        like = Like.new(
          user_id: user.id,
          video_id: video.id
        )
        expect(like.valid?).to be true
      end
    end
  end
end
