# frozen_string_literal: true

class CreateCompactChannel < ActiveRecord::Migration[7.2]
  def up
    change_column :solid_cable_messages, :channel, :binary, limit: 1024, null: false
    add_column :solid_cable_messages, :channel_hash, :integer, limit: 8, if_not_exists: true
    add_index :solid_cable_messages, :channel_hash, if_not_exists: true
    change_column :solid_cable_messages, :payload, :binary, limit: 536_870_912, null: false

    # Backfill through the migration's connection: SolidCable::Message uses its own
    # connection pool, which neither sees the new column nor the uncommitted DDL.
    select_rows("SELECT id, channel FROM solid_cable_messages").each do |id, channel|
      exec_update("UPDATE solid_cable_messages SET channel_hash = ? WHERE id = ?", "Backfill channel_hash",
        [SolidCable::Message.channel_hash_for(channel), id])
    end
  end

  def down
    change_column :solid_cable_messages, :channel, :text
    remove_column :solid_cable_messages, :channel_hash, if_exists: true
    change_column :solid_cable_messages, :payload, :text
  end
end
