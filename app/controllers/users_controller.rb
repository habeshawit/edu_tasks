class UsersController < ApplicationController

  #GET: /users
  get "/users" do
    if !Helpers.is_logged_in?(session)
      redirect to '/login'
    else
      @user = Helpers.current_user(session)  
      erb :"/users/show"
    end
  end

  # GET: /users/new
  get "/signup" do   #add a check if email address already exists
    if Helpers.is_logged_in?(session) 
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
    if Helpers.is_logged_in?(session)
      redirect to '/courses'
    end
    
    erb :"/users/login"
  end

  post '/login' do
    user = User.find_by(:username => params["username"])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/courses'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    if Helpers.is_logged_in?(session)
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
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      erb :"users/show"
    else
      redirect to '/login'
    end
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    @user = Helpers.current_user(session)
    if Helpers.is_logged_in?(session) && @user == Helpers.current_user(session)
      erb :"users/edit"
    else
      redirect '/login'
    end
  end

  # PATCH: /users/5
  patch "/users/:id" do
    user = User.find_by(:id => params["id"])
    if user == Helpers.current_user(session)
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
    if user == Helpers.current_user(session)
      session.clear
      user.delete
      redirect "/"
    else
      redirect "/"
    end
  end
  
end
