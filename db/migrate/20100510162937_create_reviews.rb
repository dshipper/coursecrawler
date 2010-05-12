class CreateReviews < ActiveRecord::Migration
  def self.up
    create_table :reviews do |t|
      t.string :course_adjective_one
      t.string :course_adjective_two
      t.string :course_adjective_three
      t.string :professor_adjective_one
      t.string :professor_adjective_two
      t.string :professor_adjective_three
      t.integer :difficulty
      t.integer :interest_level
      t.integer :professor
      t.boolean :friend
      t.timestamps
    end
  end
  
  def self.down
    drop_table :reviews
  end
end
