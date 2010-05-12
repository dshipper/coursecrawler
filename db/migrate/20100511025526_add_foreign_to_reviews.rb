class AddForeignToReviews < ActiveRecord::Migration
  def self.up
    add_column :reviews, :course_id, :integer
  end

  def self.down
    remove_column :reviews, :course_id
  end
end
