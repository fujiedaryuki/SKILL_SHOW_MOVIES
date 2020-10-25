FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user_id { user.id }
    video_id { video.id }
  end
end
