class CreateRecruitments < ActiveRecord::Migration[5.2]
  def change
    create_table :recruitments do |t|
      t.string :title, limit: 50, null: false
      t.text :content, limit: 255, null: false
      t.date :date
      t.string :picture
      t.references :user, foreign_key: true
      t.references :area, foreign_key: true

      t.timestamps
    end
    add_index :recruitments, [:user_id, :created_at]
  end
end
