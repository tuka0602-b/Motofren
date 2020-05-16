class CreateImagePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :image_posts do |t|
      t.string :picture, null: false
      t.text :content, limit: 140
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :image_posts, [:user_id, :created_at]
  end
end
