class CreateTalkRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :talk_rooms do |t|
      t.string :name, limit: 50, null: false
      t.references :recruitment, foreign_key: true

      t.timestamps
    end
  end
end
