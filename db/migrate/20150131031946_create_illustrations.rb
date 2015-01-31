class CreateIllustrations < ActiveRecord::Migration
  def change
    create_table :illustrations do |t|
      t.attachment :image
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
