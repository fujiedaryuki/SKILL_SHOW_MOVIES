class VideosController < ApplicationController
    def index
        @videos = Video.all.includes(:user).order(created_at: :desc)
    end
end
