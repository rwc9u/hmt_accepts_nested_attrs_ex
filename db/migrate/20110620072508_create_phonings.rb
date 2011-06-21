class CreatePhonings < ActiveRecord::Migration
  def self.up
    create_table :phonings, :force => true do |t|
      t.column :phone_number_id, :integer
      t.column :phonable_id, :integer
      t.column :phonable_type, :string
      t.timestamps
    end
    add_index :phonings, :phone_number_id
    add_index :phonings, [:phonable_id, :phonable_type], :name => "idx_phonings_id_type"
  end

  def self.down
    drop_table :phonings
  end
end
