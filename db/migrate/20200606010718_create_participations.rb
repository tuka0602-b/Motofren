class CreateParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :participations do |t|
      t.boolean :permission, dafault: false
      t.references :user, foreign_key: true
      t.references :recruitment, foreign_key: true

      t.timestamps
    end
  end
end
