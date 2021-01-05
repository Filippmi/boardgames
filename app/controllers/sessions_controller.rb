class SessionsController < ApplicationController
    get '/signup' do

        erb :'sessions/signup'
    end

    post '/signup' do
        current_user = User.new(params[:user])
        if current_user.save
            session[:current_user_id] = current_user.id #this is where the user is getting logged in
            redirect "/gg"
        else
            redirect "/signup"
        end
    end
end