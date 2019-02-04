class CreateMosques < ActiveRecord::Migration[5.2]
  def change
    create_table :mosques do |t|
      t.string :name
      t.boolean :publicly_accessible

      t.timestamps
    end
  end
end
