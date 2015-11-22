class AddShortToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :short, :string
  end
end
