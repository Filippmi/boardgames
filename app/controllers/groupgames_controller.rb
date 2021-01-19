class GroupGamesController < ApplicationController
    get "/my_games" do
        redirect_if_not_logged_in
        @games = current_user.games
        @game = Game.find_by_id(session[:game_id])
        erb :'/gg/index'
    end
    
    get '/save_game/new' do
        redirect_if_not_logged_in
        erb :'gg/new'
    end
    
    get "/my_games/:id" do
        redirect_if_not_logged_in
        find_game
        if_not_found_redirect
        redirect_if_not_user
        session[:game_id] = @game.id if @game
        erb :'gg/show'
    end
    
    get '/my_games/:id/edit' do
        redirect_if_not_logged_in
        find_game
        if_not_found_redirect
        redirect_if_not_user
        erb :'gg/edit'
    end


    post '/my_games' do
        game = current_user.games.build(params[:game])
        if current_user.games.where(title: params[:game][:title]).empty? && game.save
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
    end

    def redirect_if_not_user 
        redirect "/my_games" unless @game.user == current_user
    end
end
