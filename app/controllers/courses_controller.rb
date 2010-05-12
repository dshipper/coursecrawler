class CoursesController < ApplicationController
  
  before_filter :login_required
  # GET /courses
  # GET /courses.xml
  def index
    @pagetitle = "Course Crawler"
    @courses = Course.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.xml
  def show
    @course = Course.find(params[:id])
    if !@course.reviews.empty?
      @course_adj = []
      course_adj_count = Hash.new(0)
      c_adj = Array.new
    
      @prof_adj = []
      prof_adj_count = Hash.new(0)
      p_adj = Array.new
    
      @number_of_reviews = 0
      difficulty = 0
      interest_level = 0
      professor = 0
    
      recommend = 0
    
      for review in @course.reviews
        c_adj << review.course_adjective_one
        c_adj << review.course_adjective_two
        c_adj << review.course_adjective_three
      
        p_adj << review.professor_adjective_one
        p_adj << review.professor_adjective_two
        p_adj << review.professor_adjective_three
      
        @number_of_reviews += 1
        difficulty += review.difficulty
        interest_level += review.interest_level
        professor += review.professor
      
        if review.friend == true
          recommend += 1
        end
      end
    
      c_adj.each do |c|
        course_adj_count[c] += 1
      end
      i = 0
      course_adj_count.sort_by{|k,v| -v}.each { |elem|
        @course_adj[i] = elem[0]
        i+=1
      }  
  
      p_adj.each do |p|
        prof_adj_count[p] += 1
      end
      i = 0
      prof_adj_count.sort_by{|k,v| -v}.each{|elem|
        @prof_adj[i] = elem[0]
        i+=1
      }
    
      @average_difficulty = difficulty/@number_of_reviews
      @average_interest_level = interest_level/@number_of_reviews
      @average_professor = professor/@number_of_reviews
      @average_recommend = recommend/@number_of_reviews
    end
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        flash[:notice] = 'Course was successfully created.'
        format.html { redirect_to(@course) }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        flash[:notice] = 'Course was successfully updated.'
        format.html { redirect_to(@course) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to(courses_url) }
      format.xml  { head :ok }
    end
  end
end
