class CreateBoardgames < ActiveRecord::Migration
  def change
    create_table :boardgames do |t|
      t.string :title
      t.date :publishing_date
      t.string :creator
      t.integer :number_of_players

      t.timestamps null: false
    end
  end
end
