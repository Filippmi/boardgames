class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.string :genre
      t.integer :rating
      t.integer :number_of_players

      t.timestamps null: false
    end
  end
end
