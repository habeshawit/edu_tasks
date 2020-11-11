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
    @user = Helpers.current_user(session) if Helpers.is_logged_in?(session) 
    if @user
      redirect "/courses"
    else
      erb :welcome
    end
  end


end


#assignment model/attribute?
#course has many assign
#assignment belongs to course

#
