class Course < ActiveRecord::Base
  validates_presence_of :name, :teacher_name, :description
  validates_uniqueness_of :name, :message => "of course already exists"
end
