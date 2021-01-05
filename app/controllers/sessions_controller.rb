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

    get '/logout' do
        session.clear
        redirect "/home"
    end

    get '/login' do
        
        erb :'sessions/login'
    end

    post '/login' do
        current_user = User.find_by_username(params[:user][:username]) # checks to see if current_user exists
        if current_user && current_user.authenticate(params[:user][:password]) # checks to see if current_users password matches. "authenticats user"
        #first makes sure the current_user exists, then it authenticats
            session[:current_user_id] = current_user.id #logging in to sessions
            redirect "/gg"
        else
            redirect "/login"
        end
    end
end