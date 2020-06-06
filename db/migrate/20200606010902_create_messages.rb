class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content, limit: 255, null: false
      t.references :participation, foreign_key: true
      t.references :talk_room, foreign_key: true

      t.timestamps
    end
    add_index :messages, [:participation_id, :created_at]
  end
end
