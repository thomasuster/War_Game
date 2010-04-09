class CreateMaps < ActiveRecord::Migration
  def self.up
    create_table :maps do |t|
      t.string :uuid
      t.binary :data
      t.string :name
      t.integer :players

      t.timestamps
    end
  end

  def self.down
    drop_table :maps
  end
end
