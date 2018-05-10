module API  
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :path
        default_format :json
        format :json
        formatter :json, 
             Grape::Formatter::ActiveModelSerializers

        helpers do
          def permitted_params
            @permitted_params ||= declared(params, 
               include_missing: false)
          end

          def logger
            Rails.logger
          end
          
          def authenticate!
            error!('Unauthorized.', 401) unless current_user
          end

          def current_user
            user = ::User.find_by_api_key(headers['Authorization'])
            if user.nil?
              false
            else
              @current_user = user
            end
          end
          
          def owner!
            user = User.find_by_id(params[:user_id])
            if @current_user.api_key != user.api_key
              error!('Unauthorized.', 401)
            end
          end
          
        end

        rescue_from ActiveRecord::RecordNotFound do |e|
          error_response(message: e.message, status: 404)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
          error_response(message: e.message, status: 422)
        end
      end
    end
  end
end  