module API  
  module V1
    class Contribution < Grape::API
      include API::V1::Defaults
      
      resource :contributions do
        before do
         authenticate!
        end
        desc "Return all contributions filtered if type is defined"
        params do
        end
        get "" do
          if params.has_key?(:type)
            if params[:type] == "ask"
              ::Contribution.where(url: nil).order(points: :desc).all
            elsif params[:type] == "new"
              ::Contribution.order(id: :desc).all
            else
              error!('Bad Request', 400)
            end
          else
            ::Contribution.where(text: nil).hottest;
          end
        end
        
        desc "Return a contribution"
        params do
          requires :id, type: String, desc: "ID of the contribution"
        end
        get ":id" do
          ::Contribution.where(id: permitted_params[:id]).first! # Got param: " + params[:id]
        end
        
        desc "Create a contribution" 
        params do
          requires :user_id, type: Integer, desc: "User id of the contribution"
          requires :title, type: String, desc: "Title of the contribution"
          optional :url, type: String, desc: "Url of the contribution" 
          optional :text, type: String, desc: "Text of the contribution"
        end
        post "" do
          owner!
          if params[:url] == nil and params[:text] != nil
            ::Contribution.create!(declared(params))
          elsif params[:url] != nil and params[:text] == nil 
            existant = ::Contribution.where(url: params[:url])
            if !existant
              ::Contribution.create!(declared(params))
            else
              error!("This contribution already exists", 409)
            end
          elsif params[:url] != nil and params[:text] != nil
            error!("Unable to create, you must choose between type url or type ask", 400)
          end
        end
        
      end
    end
  end
end  