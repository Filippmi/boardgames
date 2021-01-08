class SessionsController < ApplicationController
    get '/signup' do
        redirect_if_logged_in
        erb :'sessions/signup'
    end

    post '/signup' do
        user = User.new(params[:user])
        if user.save
            session[:user_id] = user.id #this is where the user is getting logged in
            redirect "/my_games"
        else
            redirect "/signup"
        end
    end

    get '/logout' do
        session.clear
        redirect "/login"
    end

    get '/login' do
        redirect_if_logged_in
        erb :'sessions/login'
    end

    post '/login' do
        user = User.find_by_username(params[:user][:username]) # checks to see if current_user exists
        
        if user && user.authenticate(params[:user][:password]) # checks to see if current_users password matches. "authenticaton user"
            session[:user_id] = user.id #logging in to sessions
            redirect "/my_games"
        else
            redirect "/login"
        end
    end
end