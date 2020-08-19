class AddRateToVideo < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :rate, :float, null: false, default: 0
  end
end
