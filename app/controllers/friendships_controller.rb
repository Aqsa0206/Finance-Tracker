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
end