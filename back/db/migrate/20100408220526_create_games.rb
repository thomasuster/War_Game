class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      t.string :uuid
      t.string :owner_uuid
      t.string :player_uuid
      t.datetime :turn_expiration
      t.datetime :turn_speed
      t.string :map_uuid
      t.binary :current_map

      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
