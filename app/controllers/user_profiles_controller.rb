class UserProfilesController < ApplicationController
    before_action :authenticate_user!    

    def new
        @user_profile = UserProfile.new
    end

    def show
        @user = current_user
        @user_profile = @user.user_profile
    end

    def create
        @user = current_user
        @user_profile = @user.build_user_profile(user_profile_params)
        if @user_profile.save
            flash[:success] = "Your user profile has been created!"
            redirect_to user_weight_entries_path
        else
            render :new
        end
    end 

    def update
        @user = current_user
        @user_profile = current_user.user_profile
        if @user_profile.update_attributes(user_profile_params)
            flash[:success] = "Your user profile was updated"
            redirect_to edit_user_profile_url
        else
            render :show
        end
    end

    def edit
        begin
            # get the user profile for the user
        @user = current_user
        @user_profile = @user.user_profile
        if @user_profile.nil?
            redirect_to new_user_user_profile_url
        end
 
        rescue ActiveRecord::RecordNotFound => e
            # if the user profile doesnt' exist, don't just fail entirely, redirect the user_profile#new action
            # inform through the logs that this happened!
            logger.info e
            redirect_to new_user_profile_url
        end
        
    end

    def destroy
        @user_profile.destroy
        redirect_to root_url, notice: "User profile was successfully deleted"
    end

    private
        def user_profile_params
            params.require("user_profile").permit(["preferred_units", "height", "full_name", "gender"])
        end

end
