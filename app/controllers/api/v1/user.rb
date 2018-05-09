module API  
  module V1
    class User < Grape::API
      include API::V1::Defaults
      
      resource :users do
        before do
         authenticate!
        end
        desc "Return a user"
        params do
          requires :id, type: String, desc: "ID of the user"
        end
        get ":id" do
          ::User.where(id: permitted_params[:id]).first! # Got param: " + params[:id]
        end
       end 
    end
  end
end  