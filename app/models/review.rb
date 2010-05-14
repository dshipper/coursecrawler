class Review < ActiveRecord::Base
  belongs_to :courses
  belongs_to :users
  
  validates_presence_of        :course_adjective_one, :course_adjective_two, :course_adjective_three, :professor_adjective_one, :professor_adjective_two, :professor_adjective_three, :difficulty, :interest_level, :professor
  validates_numericality_of    :difficulty, :interest_level, :professor
  validates_length_of          :difficulty, :in => 1..10
  validates_length_of          :interest_level, :in => 1..10
  validates_length_of          :professor, :in => 1..10
 
end
