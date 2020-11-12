class UsersController < ApplicationController

  #GET: /users
  get "/users" do
    if !logged_in?
      redirect to '/login'
    else
      @user = current_user  
      erb :"/users/show"
    end
  end

  # GET: /users/new
  get "/signup" do   #add a check if email address already exists
    if logged_in? 
      redirect '/courses'
    else 
      erb :'/users/signup' 
    end
  end

  post '/signup' do
    user = User.find_by(:email => params[:email])
    if user
      #add some error message
      redirect '/login'
    end
    user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    session[:user_id] = user.id

    if user.save && user.username != "" && user.email !="" && user.password !=""
            redirect "/courses"
        else
            redirect "/signup"
        end

  end

  get '/login' do 
    if logged_in?
      redirect to '/courses'
    end
    
    erb :"/users/login"
  end

  post '/login' do
    user = User.find_by(:email => params["email"])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/courses'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
        redirect to '/'
    else
        redirect to 'views/welcome'
    end
  end

get '/users/:slug' do
  slug = params[:slug]
  @user = User.find_by_slug(slug)
  erb :"users/show"
end


  # GET: /users/5
  get "/users/:id" do
    
    binding.pry
    if !logged_in?
      redirect to '/login'
    else
      @user = User.find_by_slug(slug)
      @user = current_user  
      erb :"/users/show"
    end
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    @user = current_user
    if logged_in? && @user == current_user
      erb :"users/edit"
    else
      redirect '/login'
    end
  end

  # PATCH: /users/5
  patch "/users/:id" do
    user = User.find_by(:id => params["id"])
    if user == current_user
    user.username = params[:username]
    user.email = params[:email]
    user.password = params[:password]
    user.save
    redirect to "/users"
  else
    redirect "/users"
  end
end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    user = User.find_by(:id => params["id"])
    if user == current_user
      session.clear
      user.delete
      redirect "/"
    else
      redirect "/"
    end
  end
  
end
