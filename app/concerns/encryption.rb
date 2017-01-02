require 'active_support/concern'

module Encryption
    extend ActiveSupport::Concern
    
    def encryption_key
        # if in production, require key to be set.
        if Rails.env.production?
            raise 'Must set encryption key!' unless ENV['ENCRYPT_KEY']
            ENV['ENCRYPT_KEY']
        else
            ENV['ENCRYPT_KEY'] ? ENV['ENCRYPT_KEY'] : 's43dWz;v8PTiu;h822sAZW38xuxT>fxsA7]4gA,U'
        end
    end
end
