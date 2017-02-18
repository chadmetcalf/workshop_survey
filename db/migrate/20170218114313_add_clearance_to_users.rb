class AddClearanceToUsers < ActiveRecord::Migration[5.0]
  def self.up
    create_table :admin_users, id: :uuid do |t|
      t.string :email
      t.string :encrypted_password, limit: 128
      t.string :confirmation_token, limit: 128
      t.string :remember_token, limit: 128

      t.timestamps
    end

    add_index :admin_users, :email
    add_index :admin_users, :remember_token

    users = select_all("SELECT id FROM admin_users WHERE remember_token IS NULL")

    users.each do |user|
      update <<-SQL
        UPDATE admin_users
        SET remember_token = '#{Clearance::Token.new}'
        WHERE id = '#{user['id']}'
      SQL
    end
  end

  def self.down
    drop_table :admin_users
  end
end
