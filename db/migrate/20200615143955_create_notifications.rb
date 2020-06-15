class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :image_post_id
      t.integer :comment_id
      t.integer :recruitment_id
      t.integer :message_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
    add_index :notifications, :image_post_id
    add_index :notifications, :comment_id
    add_index :notifications, :recruitment_id
    add_index :notifications, :message_id
  end
end
