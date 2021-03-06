class ApplicationController < ActionController::Base
    protect_from_forgery unless: -> { request.format.json? } 
    def after_sign_in_path_for(resource_or_scope)
        pretty_weight_entries_path
    end

    def after_sign_out_path_for(resource_or_scope)
        new_user_session_path
    end
end
