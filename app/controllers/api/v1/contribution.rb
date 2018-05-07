module API  
  module V1
    class Contribution < Grape::API
      include API::V1::Defaults

      resource :contribution do
        desc "Return all graduates"
        get "", root: :contribution do
          "Contribution.all"
        end

        desc "Return a contribution"
        params do
          requires :id, type: String, desc: "ID of the contribution"
        end
        get ":id", root: "contribution" do
          "Contribution.where(id: permitted_params[:id]).first! # Got param: " + params[:id]
        end
      end
    end
  end
end  