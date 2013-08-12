class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  #rescue_from ActiveRecord::RecordNotFound, with: :index

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all.joins(:receiving_reports).select('reports.*, receiving_reports.read AS read').where(receiving_reports: {user_id: current_user.id}).order('receiving_reports.read', fightdate: :desc)
      respond_to do |format|
        format.html
        format.js
      end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    if @report.nil? || !@report.receiver_ids.include?(current_user.id)
            redirect_to reports_path, notice: "Der angeforderte Bericht existiert nicht."
    else
      ReceivingReport.where(user_id: current_user.id, report_id: @report.id).first.update_attribute :read, true
      respond_to do |format|
        format.html { render "show_#{@report.reportable_type}" }
        format.js
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy_receiver(current_user.id)
    respond_to do |format|
      format.html { redirect_to reports_url }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:reportable_id, :defender_planet_id, :attacker_planet_id, :fightdate, :defender_id, :attacker_id)
    end
end
