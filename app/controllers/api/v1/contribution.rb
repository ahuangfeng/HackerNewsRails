module API  
  module V1
    class Contribution < Grape::API
      include API::V1::Defaults
      
      resource :contributions do
        before do
         authenticate!
        end
        desc "Return all contributions filtered by type"
        params do
          optional :type, type: String, desc: "Type of the contribution, ask or new. If no type is specified, return all url contributions"
        end
        get "" do
          if params[:type] == "ask"
            ::Contribution.where(url: nil).order(points: :desc).all
          elsif params[:type] == "new"
            ::Contribution.order(id: :desc).all
          elsif params[:type] == nil
            ::Contribution.where(text: nil).hottest;
          else
            error!("Bad Request", 400)
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
          requires :user_id, type: Integer, desc: "ID of the user"
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
        
        desc "Modify a contribution"
        params do
          requires :user_id, type: Integer, desc: "ID of the user"
          requires :id, type: String, desc: "ID of the contribution"
          optional :title, type: String, desc: "Title of the contributions"
          optional :url, type: String, desc: "Url of the contribution" 
          optional :text, type: String, desc: "Text of the contribution"
        end
        put ":id" do
          owner!
          ::Contribution.update(contribution.id)
        end
        
        desc "Destroy a contribution"
        params do
          requires :user_id, type: Integer, desc: "ID of the user"
          requires :id, type: String, desc: "ID of the contribution"
        end
        delete ":id" do
          owner!
          contribution = ::Contribution.where(id: permitted_params[:id]).first!
          if contribution != nil
            ::Contribution.destroy(contribution.id)
          else
            error!("Bad Request", 400)
          end
        end
      end
    end
  end
end  