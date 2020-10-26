require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validates' do
    let(:user) { create(:user) }
    let(:video) { create(:video, user_id: user.id) }
    let(:valid_comment) { create(:comment, user_id: user.id, video_id: video.id) }

    context '正常系' do 
      it 'コメントを作成' do 
        comment = Comment.new(
          user_id: user.id,
          video_id: video.id,
          body: 'コメント',
        )
        expect(comment.valid?).to be true
      end
    end

    context '異常系' do
      it 'コメントが未入力は失敗' do
        valid_comment.body = ' '
        expect(valid_comment.valid?).to be false
      end

      it 'コメントが65535字以上は失敗' do
        valid_comment.body = 'a' * 65536
        expect(valid_comment.valid?).to be false
      end
    end
  end
end
