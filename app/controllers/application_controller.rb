require './config/environment'
require 'sinatra/base'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'  #tells sinatra where to find public folder & views
    set :views, 'app/views'
    register Sinatra::Flash
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
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      if logged_in?
      @user = User.find(session[:user_id])
      else
        flash[:alert_danger] = "You need to log in or sign up to access this page!"
        redirect "/"
      end
    end  
  end

end

