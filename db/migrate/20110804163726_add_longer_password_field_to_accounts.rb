class AddLongerPasswordFieldToAccounts < ActiveRecord::Migration
  def self.up
    change_column 'accounts', 'password', :string, :limit => 1024
  end

  def self.down
    change_column 'accounts', 'password', :string, :limit => 255
  end

end
