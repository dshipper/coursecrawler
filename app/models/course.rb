class Course < ActiveRecord::Base
  has_many :reviews
  validates_presence_of :name, :teacher_name, :description
  validates_uniqueness_of :name, :message => "of course already exists"
  
  def self.search(search)
    if search
      @courses = find(:all, :conditions =>  ['name LIKE ?', "%#{search}%"])
    else
      @courses = Course.all
    end
  end

end
