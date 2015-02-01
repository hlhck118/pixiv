class AddRestrictionAndPrivacyToIllustrations < ActiveRecord::Migration
  def change
    add_reference :illustrations, :restriction, index: true
    add_foreign_key :illustrations, :restrictions
    add_reference :illustrations, :privacy_level, index: true
    add_foreign_key :illustrations, :privacy_levels
  end
end
