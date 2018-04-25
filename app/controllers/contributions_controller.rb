class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy]
  before_action :prevent_unauthorized_user_access, except: [:show, :index]
  # GET /contributions
  # GET /contributions.json
  def index
    if params[:type] == 'new'
      @contributions = Contribution.order(id: :desc).all
    elsif params[:type] == 'ask'
      @contributions = Contribution.where(url: nil).order(id: :desc).all
    elsif params[:type] == 'threads'
      @contributions = Contribution.where(url: nil, title: nil)
      
     else
       @contributions = Contribution.where.not(url: nil).order(votes: :desc).all;
    end
  end
  


  # GET /contributions/1
  # GET /contributions/1.json


  # GET /contributions/new
  def new
    @contribution = Contribution.new
  end

  # GET /contributions/1/edit
  def edit
    contribution = Contribution.find_by(id: params[:id])

    if current_user.owns_contribution?(contribution)
      @contribution = contribution
    else
      redirect_to root_path, notice: "Not authorized to edit this link"
    end

  end

  # POST /contributions
  # POST /contributions.json
  def create
    # @contribution = Contribution.new(contribution_params)
    @contribution = current_user.contributions.new(contribution_params)

    if @contribution.url =~ /\s/ or @contribution.url == ''  #es vacio o con espacios trolls
      @contribution.url = nil
    end
    if @contribution.url != nil #nil = null
      @contribution.text = nil
    end
    @contribution.votes = 0
    @contribution.numComments = 0

    respond_to do |format|
      if @contribution.save
        format.html { redirect_to contributions_url}
        format.json { render :show, status: :created, location: @contribution }
    
      else
        format.html { render :new }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contributions/1
  # PATCH/PUT /contributions/1.json
  def update
    respond_to do |format|
      if @contribution.update(contribution_params)
        format.html { redirect_to contributions_url}
        format.json { render :show, status: :ok, location: @contribution }
      else
        format.html { render :edit }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributions/1
  # DELETE /contributions/1.json
  def destroy

    contribution = Contribution.find_by(id: params[:id])

    if current_user.owns_contribution?(contribution)
      @contribution = contribution
      contribution.destroy
      redirect_to root_path, notice: "Link successful deleted"
    else
      redirect_to root_path, notice: "Not authorized to edit this link"
    end
  end

  def vote
    @contribution = Contribution.find(params[:id])
    @contribution.upVote()
    @contribution.save
    respond_to do |format|
      format.html { redirect_to request.referrer}
      format.json { head :no_content }
    end
  end
 
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribution
      @contribution = Contribution.find(params[:id])
      @comments = @contribution.comments
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contribution_params
      params.require(:contribution).permit(:title, :url, :text) #TODO: perquè comment_id?
    end
end
