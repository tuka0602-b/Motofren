class CreateImagePostLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :image_post_likes do |t|
      t.references :user, foreign_key: true
      t.references :image_post, foreign_key: true

      t.timestamps
    end
    add_index :image_post_likes, [:user_id, :image_post_id], unique: true
  end
end
