class GroupGamesController < ApplicationController

    get '/gamelist/new' do
        redirect_if_not_logged_in
        erb :'gg/new'
    end
    
    get '/gamelist/:id' do #dynamic route
        redirect_if_not_logged_in
        find_game
        session[:game_id] = @game.id if @game #sets the session id to a game id and makes a cookie
        if_not_found_redirect
        erb :'gg/show'
    end
    
    get '/gamelist/:id/edit' do #dynamic route
        redirect_if_not_logged_in
        find_game
        if_not_found_redirect
        erb :'gg/edit'
    end

    get '/gamelist' do
        redirect_if_not_logged_in
        @games = Game.all
        @game = Game.find_by_id(session[:game_id])
        erb :'/gg/index'
    end

    post '/gamelist' do
        game = Game.new(params[:game])
        
        if game.save
            redirect '/gamelist'
        else
            redirect '/gamelist/new'
        end
    end

    patch '/gamelist/:id' do #dynamic route
        find_game
        if_not_found_redirect
        if @game.update(params[:game])
            redirect "/gamelist/#{@game.id}"
        else
            redirect "/gamelist/#{@game.id}/edit"
        end
    end

    delete '/gamelist/:id' do #dynamic route
        find_game
        @game.destroy if @game
        redirect "/gamelist"
    end

    private
        def find_game
            @game = Game.find_by_id(params[:id])
        end
    #checks for a game and redirects if no game is found
    #helps keep the webapp from breaking
        def if_not_found_redirect
            redirect "/gamelist" unless @game
        end
end
