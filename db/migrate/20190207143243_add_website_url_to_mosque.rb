class AddWebsiteUrlToMosque < ActiveRecord::Migration[5.2]
  def change
    add_column :mosques, :website_url, :string
  end
end
