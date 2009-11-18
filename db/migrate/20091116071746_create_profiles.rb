class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.integer :user_id
      t.string  :first_name
      t.string  :middle_name
      t.string  :last_name
      t.timestamps
    end

    add_index :profiles, :user_id
  end

  def self.down
    remove_index :profiles, :user_id
    drop_table :profiles
  end
end
