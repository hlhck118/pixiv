class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.references :user, index: true, unique: true
      t.string :nickname
      t.attachment :avatar
      t.boolean :gender
      t.boolean :gender_public
      t.date :birthdate
      t.boolean :birthdate_public

      t.timestamps null: false
    end
    add_foreign_key :user_profiles, :users
  end
end
