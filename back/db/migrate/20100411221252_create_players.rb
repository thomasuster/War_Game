class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :uuid
      t.string :user_uuid
      t.string :game_uuid

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
