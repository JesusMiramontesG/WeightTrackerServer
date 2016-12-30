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
        @preferred_units = @user.user_profile.prefered_units
        @preferred_units_string = @preferred_units == 0 ? "Pounds" : "Kilograms"

        # get the user's height from the profile so we can compute BMI for each entry 
        @user_height = @user.user_profile.height
        @weight_entries = current_user.weight_entries.order('created_at DESC')

        # if there ARE weight entries, then grab them and return first and second weight entries for display
        if @weight_entries.any?
            # calculate the difference and return if the difference is a net loss
            first = @weight_entries.first.exact_weight
            second = @weight_entries.second.nil? ? 0: @weight_entries.second.exact_weight
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
            @graph_labels.push(entry.updated_at.in_time_zone("Eastern Time (US & Canada)").strftime("%m-%d-%Y %r"))
            @graph_data.push(entry.exact_weight)
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
            render :new
        end
    end
    
    def update
        @weight_entry = WeightEntry.find(params[:id])
        if @weight_entry.update_attributes(weight_entry_params)
            flash[:success] = "Entry has been updated"
        else
            render :show
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
