class AddDefaultUser < ActiveRecord::Migration
  def self.up
    if !User.find_by_login('ccadmin')
      User.create(:login => 'ccadmin', :email => "dshipper@gmail.com", :password => "Gremlin5!", :password_confirmation => "Gremlin5!")
    end
  end

  def self.down
  end
end
