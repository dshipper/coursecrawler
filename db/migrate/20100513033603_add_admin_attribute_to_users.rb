class AddAdminAttributeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean
    
    @users = User.find(:all)
    @users.each do |user|
      user.update_attribute(:admin, false)
    end
  end

  def self.down
    remove_column :users, :admin
  end
end
