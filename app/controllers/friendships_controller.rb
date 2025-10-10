class FriendshipsController < ApplicationController

    def index
        @user = current_user
    end

    def destroy
        friend = User.find(params[:id])
        @friend = Friendship.where(user_id: current_user, friend_id: friend).first
        @friend.destroy
        flash[:notice] = "#{friend.full_name} was successfully removed from your friends"
        redirect_to friendships_path
    end

    def search
        if params[:friend].present?
            @friends = User.search(params[:friend])
            @friends = current_user.except_current_user(@friends)
            if @friends
                respond_to do |format|
                format.js { render partial: 'friendships/friend_result' }
                end
            else
                respond_to do |format|
                flash.now[:alert] = "Couldn't find user"
                format.js { render partial: 'friendships/friend_result' }
                end
            end
            else
            respond_to do |format|
                flash.now[:alert] = "Please enter a friend name or email to search"
                format.js { render partial: 'friendships/friend_result' }
            end
        end
    end

end