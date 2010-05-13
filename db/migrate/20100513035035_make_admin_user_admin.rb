class MakeAdminUserAdmin < ActiveRecord::Migration
  def self.up
    if(user = User.find_by_login('ccadmin'))
      user.admin = "true"
      user.save
    end
  end

  def self.down
  end
end
