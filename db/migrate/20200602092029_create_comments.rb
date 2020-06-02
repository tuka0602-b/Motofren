class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content, limit: 140, null: false
      t.references :user, foreign_key: true
      t.references :image_post, foreign_key: true

      t.timestamps
    end
    add_index :comments, [:created_at]
  end
end
