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
      
      total_math = 0
      yes_math = 0
      
      total_science = 0
      yes_science = 0
      
      total_computers = 0
      yes_computers = 0
      
      total_english = 0
      yes_english = 0
      
      total_history = 0
      yes_history = 0
      
      total_languages = 0
      yes_languages = 0
      
      @pct_math = 0.0
      @pct_science = 0.0
      @pct_computers = 0.0
      @pct_english = 0.0
      @pct_history = 0.0
      @pct_languages = 0.0
      
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
      
        if review.friend
          recommend += 1
          logger.info "recommendations: #{recommend}"
        end
        
        #now lets count majors
        #the following code is so ugly you may puke if you read it
        #but we're going for development speed here...
        user = User.find_by_id review.user_id
        if(user)
          if user.major == "Math"
            total_math += 1
            if review.friend
              yes_math += 1
            end
          end
        
          if user.major == "Science"
            total_science += 1
            if review.friend
              yes_science += 1
            end
          end
        
          if user.major == "Computers"
            total_computers += 1
            if review.friend
              yes_computers += 1
            end
          end
        
          if user.major == "English"
            total_english += 1
            if review.friend
              yes_english += 1
            end
          end
        
          if user.major == "History"
            total_history += 1
            if review.friend
              yes_history += 1
            end
          end
        
          if user.major == "Languages"
            total_languages += 1
            if review.friend
              yes_languages += 1
            end
          end
        end
            
        
      end
      if(total_math > 0)
        @pct_math = yes_math.to_f/total_math.to_f*100.0
      end
      if(total_science > 0)
        @pct_science = yes_science.to_f/total_science.to_f*100.0
      end
      if(total_computers > 0)
        @pct_computers = yes_computers.to_f/total_computers.to_f*100.0
      end
      if(total_english > 0)
        @pct_english = yes_english.to_f/total_english.to_f*100.0
      end
      if(total_history > 0)
        @pct_history =  yes_history.to_f/total_history.to_f*100.0
      end
      if(total_languages > 0)
        @pct_language = yes_languages.to_f/total_languages.to_f*100.0
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
    
      @average_difficulty = difficulty.to_f/@number_of_reviews.to_f
      @average_interest_level = interest_level.to_f/@number_of_reviews.to_f
      @average_professor = professor.to_f/@number_of_reviews.to_f
      @average_recommend = recommend.to_f/@number_of_reviews.to_f*100.0
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
