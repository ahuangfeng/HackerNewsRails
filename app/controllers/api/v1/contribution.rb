module API  
  module V1
    class Contribution < Grape::API
      include API::V1::Defaults

      resource :contributions do
        desc "Return all contributions filtered if type is defined"
        params do
          #aqui dirli al swagger que tinc un parametre type amb els seus estats etc
        end
        get "" do
          if params.has_key?(:type)
            if params[:type] == "ask"
              ::Contribution.where(url: nil).order(points: :desc).all
            elsif params[:type] == "new"
              ::Contribution.order(id: :desc).all
            else
              status :bad_request #mirar si retorna be el status
            end
          else
            ::Contribution.where(text: nil).hottest;
          end
        end

        desc "Return a contribution"
        params do
          requires :id, type: String, desc: "ID of the contribution"
        end
        get "?type=ask"do
          
          #::Contribution.where(id: permitted_params[:id]).first! # Got param: " + params[:id]
        end
      end
    end
  end
end  