class ChangePublishedAtToStringInBooks < ActiveRecord::Migration[8.1]
  def change
    change_column :books, :published_at, :string
  end
end