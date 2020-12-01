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
  get "/signup" do  
    if logged_in? 
      redirect '/courses'
    else 
      erb :'/users/signup' 
    end
  end

  post '/signup' do
    user = User.find_by(:email => params[:email])
    if user
      flash[:alert_danger] = "An account with this email address is already registered. Log in or use a different email address to continue!"
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
    elsif user!=nil && !user.authenticate(params[:password])
      flash[:alert_danger] = "Incorrect password. Try again!"
      redirect to '/login'
    else
      flash[:alert_danger] = "Could not find a matching account. Please create an account to begin!"
      redirect to '/login'
    end
  end

  get '/logout' do
    if logged_in?
        session.clear
        redirect to '/'
    else
        redirect to '/'
    end
  end

get '/users/:id' do
  if logged_in?
    erb :"users/show"
  else
    flash[:alert_danger] = "This page does not exist! Redirecting to your profile."
    redirect '/users'
  end
end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    if logged_in?
      erb :"users/edit"
    else
      flash[:alert_danger] = "This page does not exist! Redirecting to your profile."
      redirect '/users/:slug'
    end
  end

  # PATCH: /users/5
  patch "/users/:id" do
    user = User.find_by(:id => params[:id])
    if user == current_user
    user.username = params[:username]
    user.email = params[:email]
    user.password = params[:password]
    user.save
    redirect to "/users"
  else
    flash[:alert_danger] = "This page does not exist! Redirecting to your profile."
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
