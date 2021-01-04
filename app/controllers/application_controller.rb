require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :session
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, ENV['session_secret']
  end

  get "/" do
    erb :welcome
  end

end
