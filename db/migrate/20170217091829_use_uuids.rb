class UseUuids < ActiveRecord::Migration[5.0]
  def self.up
    enable_extension "uuid-ossp"
  end

  def self.down
    disable_extension "uuid-ossp"
  end
end
