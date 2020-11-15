class CoursesController < ApplicationController


  # GET: /tasks
  get "/courses" do
    if !logged_in?
      flash[:alert_danger] = "You must log in to view your courses!"
      redirect to '/login'
    else
      @user = current_user 
      @courses= @user.courses
      erb :"/courses/index"
    end
    
  end

  # GET: /tasks/new
  get "/courses/new" do
    if logged_in?
      erb :"/courses/new"
  else
    flash[:alert_danger] = "You must be logged in to see your courses"
    redirect to 'login'
  end
    
  end

  # POST: /tasks
  post "/courses" do
    user = current_user
    if !params["name"].empty?
        @course = Course.create(:name => params["name"], :schedule => params[:schedule], :assignments => params[:assignments], :notes => params[:notes], :user_id => user.id)
        if @course.save
            redirect "/courses"
        end   
    else
      redirect "/courses/new"
    end
  end

  get "/courses/assignments" do
    @courses = current_user.courses
    erb :"courses/assignments"
  end

  get "/courses/notes" do
    @courses = current_user.courses
    erb :"courses/notes"
  end
  
  # GET: /tasks/5
  get "/courses/:id" do
    @course = Course.find_by_id(params[:id])

    if logged_in? && @course.user == current_user
      erb :"courses/show"
    else
      flash[:alert_danger] = "Could not find this course. Redirecting to your courses"
      redirect to '/courses'
    end
  end

  # GET: /tasks/5/edit
  get "/courses/:id/edit" do
     @course = Course.find_by_id(params[:id])
    if logged_in? && @course.user == current_user
      erb :"courses/edit"
    else
      flash[:alert_danger] = "You need to login or signup to access this page"
      redirect to '/'
    end
  end

  # PATCH: /tasks/5
  patch "/courses/:id" do
    @course = Course.find_by_id(params[:id])
        
        if @course && @course.user == current_user
            @course.name = params[:name]
            @course.schedule = params[:schedule]
            @course.assignments = params[:assignments]
            @course.notes = params[:notes]
            @course.save
            redirect to "/courses/#{@course.id}"
        else
          flash[:alert_danger] = "Could not find this course! Redirecting your courses"
          redirect "/courses"
        end
  end

  # DELETE: /tasks/5/delete
  delete "/courses/:id/delete" do
    @course = current_user.courses.find_by(:id => params[:id])
        if @course
          #check if sure
          @course.delete
          redirect "/courses"
        else
          redirect "/login"
        end
  end
  
end
