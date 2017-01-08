class WeightEntriesController < ApplicationController
    before_action :authenticate_user!

    def index
        @user = current_user

        # before the user does much of anything, make sure their profile is up to date
        if needs_user_profile_completion(@user)
            redirect_to edit_user_profile_path(@user)
            return
        end

        # get the preferred units from the profile
        @preferred_units = @user.user_profile.preferred_units.to_i
        @preferred_units_string = @preferred_units == 0 ? "Pounds" : "Kilograms"

        # get the preferred timezone from the user profile
        @preferred_timezone = @user.user_profile.preferred_timezone unless @user.user_profile.preferred_timezone.nil?
        
        # if the user hasn't added a timezone to their profile yet, redirect them to profile#edit for completion
        redirect_to edit_user_profile_path(@user), :alert => "Please update your preferred timezone before continuing." if @preferred_timezone.nil? 
        
        # get the user's height from the profile so we can compute BMI for each entry 
        @user_height = @user.user_profile.height.to_f
        @weight_entries = current_user.weight_entries.order('created_at DESC')

        # if there ARE weight entries, then grab them and return first and second weight entries for display
        if @weight_entries.any?
            # calculate the difference and return if the difference is a net loss
            first = @weight_entries.first.nil? ? 0 : @weight_entries.first.exact_weight.to_f
            second = @weight_entries.second.nil? ? 0 : @weight_entries.second.exact_weight.to_f
            @current_diff = second - first
            @diff_is_loss = @current_diff > 0 ? true:false

            # is this the first entry? If so, don't tell the user they've gained/lost weight
            if second == 0
                @first_diff = true
            end
        else
            # we didn't have any reasonble values to work with yet, so don't return any valuable data
            @current_diff = 0
            @diff_is_loss = false
        end
        @graph_labels = Array.new
        @graph_data = Array.new
        @weight_entries.each do |entry|
            @graph_labels.push(entry.updated_at.in_time_zone(@preferred_timezone).strftime("%b, %d %Y %I:%S%p"))
            @graph_data.push(entry.exact_weight.to_f)
        end
    end

    def new
        @weight_entry = WeightEntry.new
    end

    def create
        @user = current_user
        @weight_entry = @user.weight_entries.build(weight_entry_params)
        if @weight_entry.save
            flash[:success] = "Your weight entry has been saved!"
            redirect_to user_weight_entries_path
        else
            # Check to see if there was an ActiveRecord validation that failed.
            # If so, grab the errors and pass them to the flash for rendering
            if @weight_entry.errors.any?
                @new_entry_errors = @weight_entry.errors.full_messages.to_sentence
                puts  
            else
                # If there are no ActiveRecord validations that failed and there was still a failure...
                # Let the user know something went wrong with a generic failure
                @new_entry_errors = "An error occurred when saving your entry. Try that again?"
            end
            flash[:notice] = @new_entry_errors
            redirect_to user_weight_entries_path
        end
    end
    
    def update
        @weight_entry = WeightEntry.find(params[:id])
        if @weight_entry.update_attributes(weight_entry_params)
            flash[:success] = "Entry has been updated"
        else
            render :index
        end
    end

    def edit
        @weight_entry = WeightEntry.find(params[:id])
    end

    def destroy
        @weight_entry.destroy
        redirect_to users_url, notice: "Entry was successfully deleted"
    end

    private
        def weight_entry_params
            params.require(:weight_entry).permit(:exact_weight)
        end

        def needs_user_profile_completion(user)
            if user.user_profile.nil?
                return true
            end
            return false
        end
end
