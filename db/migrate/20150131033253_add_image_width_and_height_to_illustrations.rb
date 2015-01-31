class AddImageWidthAndHeightToIllustrations < ActiveRecord::Migration
  def change
    add_column :illustrations, :image_width, :integer, after: :image_file_size
    add_column :illustrations, :image_height, :integer, after: :image_width
  end
end
