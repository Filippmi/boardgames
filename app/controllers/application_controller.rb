require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, ENV['SESSION_SECRET']
  end

  get "/" do
    redirect "/home"
  end

  get "/home" do
    erb :welcome
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def redirect_if_logged_in #authorization 
      redirect "/gamelist" if logged_in?
    end

    def redirect_if_not_logged_in #authorization 
      redirect "/login" unless logged_in?
    end

    def current_user
      User.find_by_id(session[:user_id])
    end
  end
end
