# frozen_string_literal: false

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :update_from_menu] # probably want to keep using this

  def index
    @users = User.all.limit(50)
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        User.broadcast_notification({ title: 'User: '+current_user.name, message: 'Info was changed!' })
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    end

  def update_from_menu
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_back(fallback_location: root_path) }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:role, :name, :user_picture, :locale)
  end

end
