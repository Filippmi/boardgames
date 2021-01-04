class GamesController < ApplicationController

    get '/games/new' do
        erb :'games/new'
    end

    get '/games/:id' do
        find_game
        erb :'games/show'
    end

    get '/games/:id/edit' do
        find_game
        erb :'games/edit'
    end
    
    get '/games' do
        @games = Game.all

        erb :'/games/index'
    end

    post '/games' do
        game = Game.new(params[:game])

        if game.save
            redirect '/games'
        else
            redirect '/games/new'
        end
    end

    patch '/games/:id' do
        find_game
        if @game.update(params[:game])
            redirect "/games/#{@game.id}"
        else
            redirect "/games/#{@game.id}/edit"
        end
    end

    private
        def find_game
            @game = Game.find_by_id(params[:id])
        end
end
