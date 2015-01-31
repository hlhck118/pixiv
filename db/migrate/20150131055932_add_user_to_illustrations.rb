class AddUserToIllustrations < ActiveRecord::Migration
  def change
    add_reference :illustrations, :user, index: true, after: :id
    add_foreign_key :illustrations, :users
  end
end
