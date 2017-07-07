class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    type = params[:type]
    @title = type
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:danger] = t "user_not_found"
      redirect_to root_path
    end
    @users = @user.send(type).paginate page: params[:page]
  end

  def create
    @user = User.find_by id: params[:followed_id]
    if @user
      current_user.follow @user
      respond_to do |format|
        format.html{redirect_to @user}
        format.js
      end
    else
      flash[:danger] = t "user_not_found"
      redirect_to root_path
    end
  end

  def destroy
    if relationship = Relationship.find_by(id: params[:id])
      if relationship.follower_id == current_user.id
        @user = relationship.followed
        current_user.unfollow @user
        respond_to do |format|
          format.html{redirect_to @user}
          format.js
        end
      else
        flash[:danger] = t "not_following_this_user"
        redirect_to root_path
      end
    else
      flash[:danger] = t "relationship_not_found"
      redirect_to root_path
    end
  end
end
