class CommentsController < ApplicationController
  before_action :prevent_unauthorized_user_access, except: :index

  def index
  end

  def edit
  end
end
