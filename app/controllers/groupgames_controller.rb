class GroupGamesController < ApplicationController

    get '/save_game/new' do
        redirect_if_not_logged_in
        erb :'gg/new'
    end
    
    get "/my_games/:id" do #dynamic route
        redirect_if_not_logged_in
        find_game
        if_not_found_redirect
        redirect_if_not_user
        session[:game_id] = @game.id if @game #sets the session id to a game id and makes a cookie
        erb :'gg/show'
    end
    
    get '/my_games/:id/edit' do #dynamic route
        redirect_if_not_logged_in
        find_game
        if_not_found_redirect
        redirect_if_not_user
        erb :'gg/edit'
    end

    get "/my_games" do
        redirect_if_not_logged_in
        @games = current_user.games #only allowes the current user to see their own games
        @game = Game.find_by_id(session[:game_id])
        erb :'/gg/index'
    end

    post '/my_games' do
        game = current_user.games.build(params[:game]) #establishes connection between a user and their games\
        if game.save
            redirect '/my_games'
        else
            redirect '/save_game/new'
        end
    end

    patch '/my_games/:id' do
        find_game
        if_not_found_redirect
        if @game.update(params[:game])
            redirect "/my_games/#{@game.id}"
        else
            redirect "/my_games/#{@game.id}/edit"
        end
    end

    delete '/my_games/:id' do
        find_game
        if_not_found_redirect
        redirect_if_not_user
        @game.destroy
        redirect "/my_games"
    end

    private
    def find_game
        @game = Game.find_by_id(params[:id])
    end

    def if_not_found_redirect
        redirect "/my_games" unless @game
        #checks for a game and redirects if no game is found
        #helps keep the webapp from breaking
    end

    def redirect_if_not_user 
        redirect "/my_games" unless @game.user == current_user
        #authorization
        #helps keep the webapp from breaking do to unauthorized users.
    end
end
