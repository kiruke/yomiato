class AddImageLinkAndInfoLinkToBooks < ActiveRecord::Migration[8.1]
  def change
    add_column :books, :image_link, :string
    add_column :books, :info_link, :string
  end
end
