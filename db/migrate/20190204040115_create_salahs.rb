class CreateSalahs < ActiveRecord::Migration[5.2]
  def change
    create_table :salahs do |t|
      t.string :name
      t.datetime :begins
      t.datetime :iqamah
      t.references :mosque, foreign_key: true

      t.timestamps
    end
  end
end
