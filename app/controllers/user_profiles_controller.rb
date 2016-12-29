class UserProfilesController < ApplicationController
    before_action :authenticate_user!    

    def new
        @user_profile = UserProfile.new
    end

    def create
        @user = current_user
        @user_profile = @user.build_user_profile(user_profile_params)
        if @user_profile.save
            flash[:success] = "Your user profile has been created!"
        else
            render :new
        end
    end 

    def update
        @user = current_user
        @user_profile = current_user.user_profile
        if @user_profile.update_attributes(user_profile_params)
            flash[:success] = "Your user profile was updated"
        else
            render :show
        end
    end

    def edit
        @user_profile = UserProfile.find(params[:id])
    end

    def destroy
        @user_profile.destroy
        redirect_to root_url, notice: "User profile was successfully deleted"
    end

end
