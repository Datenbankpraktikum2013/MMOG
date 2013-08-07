class RelationshipsController < ApplicationController
before_filter :signed_in_user

  def create
    @user = User.find(params[:relationship][:user_id])
    current_user.make_friendship!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).friend
    current_user.end_friendship!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      fromat.js
  end
end 