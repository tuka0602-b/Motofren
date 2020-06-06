class CreateRecruitmentLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :recruitment_likes do |t|
      t.references :user, foreign_key: true
      t.references :recruitment, foreign_key: true

      t.timestamps
    end
    add_index :recruitment_likes, [:user_id, :recruitment_id], unique: true
  end
end
