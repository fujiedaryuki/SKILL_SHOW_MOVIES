class AddVideoImageToVideo < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :video_image, :string
  end
end
