class CoursesController < ApplicationController

  # GET: /tasks
  get "/courses" do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    else
        @courses= Course.all
        @user = Helpers.current_user(session)
        erb :"/courses/index"
    end
    
  end

  # GET: /tasks/new
  get "/courses/new" do
    if Helpers.is_logged_in?(session)
      erb :"/courses/new"
  else
      redirect to "users/login"
  end
    
  end

  # POST: /tasks
  post "/courses" do
    user = Helpers.current_user(session)
    if !params["name"].empty?
        course = Course.create(:name => params["name"], :schedule => params[:schedule], :assignments => params[:assignments], :notes => params[:notes], :user_id => user.id)
        if course.save
            redirect "/courses"
        end   
    else
        redirect "/courses/new"
    end
  end

  # GET: /tasks/5
  get "/courses/:id" do
    if Helpers.is_logged_in?(session)
      @course = Course.find_by(id: params[:id])
      erb :"courses/show"
    else
      redirect to '/login'
    end
  end

  # GET: /tasks/5/edit
  get "/courses/:id/edit" do
    
  end

  # PATCH: /tasks/5
  patch "/courses/:id" do
    redirect "/courses/:id"
  end

  # DELETE: /tasks/5/delete
  delete "/courses/:id/delete" do
    redirect "/courses"
  end
end
