class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :connecter_id
      t.integer :connected_id

      t.timestamps
    end

    add_index :connections, :connecter_id
    add_index :connections, :connected_id
    add_index :connections, [:connecter_id, :connected_id], unique: true
  end
end
