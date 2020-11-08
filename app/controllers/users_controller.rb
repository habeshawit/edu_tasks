class UsersController < ApplicationController

  # GET: /users
  # get "/users" do
  #   erb :"/users/index"
  # end

  # GET: /users/new
  get "/signup" do
    if Helpers.is_logged_in?(session) 
      redirect '/courses'
    else 
      erb :'/users/signup' 
    end
  end

  # POST: /users
  # post "/users" do
  #   redirect "/users"
  # end
  post '/signup' do
    user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    session[:user_id] = user.id

    if user.save && user.username != "" && user.email !="" && user.password !=""
            redirect "/courses"
        else
            redirect "/signup"
        end

  end

  # GET: /users/5
  get "/users/:id" do
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
