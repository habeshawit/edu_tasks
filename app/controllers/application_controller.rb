require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    # use Rack::Flash
    enable :sessions
    set :session_secret, "secret"
    
  end

  get "/" do
    @user = current_user if logged_in?
    if @user
      redirect "/courses"
    else
      erb :welcome
    end
  end

  helpers do
    def current_user
      @user = User.find(session[:user_id])
    end
  
    def logged_in?
      !!session[:user_id]
    end
  end


end

