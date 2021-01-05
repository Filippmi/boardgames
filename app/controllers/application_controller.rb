require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, ENV['SESSION_SECRET']
  end

  get "/" do
    redirect '/home'
  end

  get "/home" do
    erb :welcome
  end

  helpers do
    def logged_in?
      !!session[:current_user_id]
    end
  end

end
