class UserProfilesController < ApplicationController
    before_action :authenticate_user!    

    def new
        @user_profile = UserProfile.new
        @us_zones = get_us_timezones
    end

    def show
        @user = current_user
        @us_zones = get_us_timezones
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
        @us_zones = get_us_timezones
        @user_profile = current_user.user_profile
        if @user_profile.update_attributes(user_profile_params)
            flash[:notice] = "Your user profile has been updated!"
            puts flash[:notice]
            redirect_to edit_user_profile_path(@user)
        else
            render :edit
        end
    end

    def edit
        begin
        @user = current_user
        # get US timezones so the user can set this in their profile
        @us_zones = get_us_timezones
        #get the user profile 
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
            params.require("user_profile").permit(["preferred_units", "height", "full_name", "gender", "preferred_timezone"])
        end

        def get_us_timezones
            us_timezones = []
            ActiveSupport::TimeZone.us_zones.each do |zone|
                tz_info = ActiveSupport::TimeZone.find_tzinfo(zone.name)
                tz = {"name" => zone.name, "tz_id" => tz_info.identifier}
                us_timezones.push(tz)
            end
            return us_timezones
        end
end
