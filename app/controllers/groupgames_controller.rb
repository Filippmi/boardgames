class GroupGamesController < ApplicationController

    get '/gg/new' do
        erb :'gg/new'
    end

    get '/gg/:id' do #dynamic route
        find_game
        session[:game_id] = @game.id if @game #sets the session id to a game id and makes a cookie
        if_not_found_redirect
        erb :'gg/show'
    end

    get '/gg/:id/edit' do #dynamic route
        fdirect
        erb :'gg/edit'
        if_not_found_redirect
    end
    
    get '/gg' do
        @games = Game.all
        @game = Game.find_by_id(session[:game_id])
        erb :'/gg/index'
    end

    post '/gg' do
        game = Game.new(params[:game])

        if game.save
            redirect '/gg'
        else
            redirect '/gg/new'
        end
    end

    patch '/gg/:id' do #dynamic route
        find_game
        if_not_found_redirect
        if @game.update(params[:game])
            redirect "/gg/#{@game.id}"
        else
            redirect "/gg/#{@game.id}/edit"
        end
    end

    delete '/gg/:id' do #dynamic route
        find_game
        @game.destroy if @game
        redirect "/gg"
    end

    private
        def find_game
            @game = Game.find_by_id(params[:id])
        end
    #checks for a game and redirects if no game is found
    #helps keep the webapp from breaking
        def if_not_found_redirect
            redirect "/gg" unless @game
        end
end
