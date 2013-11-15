class AddConnectionsCountToUser < ActiveRecord::Migration
  def up
    add_column :users, :connections_count, :integer, default: 0
    add_index :users, :connections_count

    update <<-SQL
      UPDATE users SET connections_count = ( SELECT count(*) FROM connections
      WHERE connections.connecter_id = users.id )
     SQL
  end

  def down
    remove_index :users, :connections_count
    remove_column :users, :connections_count
  end
end
