class RelationshipsController < ApplicationController
  before_action :set_relationship, only: [:destroy]
  before_filter :authenticate_user!
  # GET /relationships
  # GET /relationships.json
  def index
    @relationships = current_user.friends
  end

  # GET /relationships/new
  def new
    @relationship = Relationship.new
  end

  # DELETE /relationships/1
  # DELETE /relationships/1.json
  def destroy
    current_user.end_friendship!(@relationship.friend)
    respond_to do |format|
      format.html { redirect_to relationships_url }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relationship
      #find relationship
      @relationship = Relationship.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relationship_params
      params[:relationship]
    end
end
