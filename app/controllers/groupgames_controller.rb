class GroupGamesController < ApplicationController

    get '/gamelist/new' do
        redirect_if_not_logged_in
        erb :'gg/new'
    end
    
    get '/gamelist/:id' do #dynamic route
        redirect_if_not_logged_in
        find_game
        if_not_found_redirect
        redirect_if_not_user
        session[:game_id] = @game.id if @game #sets the session id to a game id and makes a cookie
        erb :'gg/show'
    end
    
    get '/gamelist/:id/edit' do #dynamic route
        redirect_if_not_logged_in
        find_game
        if_not_found_redirect
        redirect_if_not_user
        erb :'gg/edit'
    end

    get '/gamelist' do
        redirect_if_not_logged_in
        @games = current_user.games #only allowes the current user to see their own games
        @game = Game.find_by_id(session[:game_id])
        erb :'/gg/index'
    end

    post '/gamelist' do
        game = current_user.games.build(params[:game]) #establishes connection between a user and their games
        if game.save
            redirect '/gamelist'
        else
            redirect '/gamelist/new'
        end
    end

    patch '/gamelist/:id' do
        find_game
        if_not_found_redirect
        if @game.update(params[:game])
            redirect "/gamelist/#{@game.id}"
        else
            redirect "/gamelist/#{@game.id}/edit"
        end
    end

    delete '/gamelist/:id' do
        find_game
        if_not_found_redirect
        redirect_if_not_user
        @game.destroy
        redirect "/gamelist"
    end

    private
    def find_game
        @game = Game.find_by_id(params[:id])
    end

    def if_not_found_redirect
        redirect "/gamelist" unless @game
        #checks for a game and redirects if no game is found
        #helps keep the webapp from breaking
    end

    def redirect_if_not_user 
        redirect "/gamelist" unless @game.user == current_user
        #authorization
        #helps keep the webapp from breaking do to unauthorized users.
    end
end
