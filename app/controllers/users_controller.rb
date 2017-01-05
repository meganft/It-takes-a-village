class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update]

  def show
    @hash = Gmaps4rails.build_markers(@user) do |user, marker|
      marker.lat user.latitude
      marker.lng user.longitude
      marker.json({:id => user.id})
      # marker.picture({
      #   "url" => "/pin.png",
      #   "width" => 32,
      #   "height" => 32
      #   })
    end

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Successfully created an account!"
      redirect_to dashboard_path
    else
      @categories = Category.all
      flash[:error] = "Something went wrong. Please try again."
      render :new
    end
  end

  def edit

  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "#{@user.first_name} account updated!"
      redirect_to user_path(@user)
    else
      flash.now[:error] = "Account didn't update. Try again."
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :street_number,
                                   :unit_number,
                                   :city,
                                   :state,
                                   :zip_code,
                                   :phone,
                                   :email,
                                   :password,
                                   :password_confirmation,
                                   :picture)
      #took out category_id here, will have to add in when we put this functionality back in
    end

    def set_user
      @user = current_user
    end

end
