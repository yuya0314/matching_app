class AddSelfIntroductionToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :self_introduction, :text
    add_column :users, :fan_years, :integer
    add_column :users, :favorite_player, :text
  end
end
