class ReceivingReportsController < ApplicationController
  before_action :set_receiving_report, only: [:show, :edit, :update, :destroy]

  # GET /receiving_reports
  # GET /receiving_reports.json
  def index
    @receiving_reports = ReceivingReport.all
  end

  # GET /receiving_reports/1
  # GET /receiving_reports/1.json
  def show
  end

  # GET /receiving_reports/new
  def new
    @receiving_report = ReceivingReport.new
  end

  # GET /receiving_reports/1/edit
  def edit
  end

  # POST /receiving_reports
  # POST /receiving_reports.json
  def create
    @receiving_report = ReceivingReport.new(receiving_report_params)

    respond_to do |format|
      if @receiving_report.save
        format.html { redirect_to @receiving_report, notice: 'Receiving report was successfully created.' }
        format.json { render action: 'show', status: :created, location: @receiving_report }
      else
        format.html { render action: 'new' }
        format.json { render json: @receiving_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receiving_reports/1
  # PATCH/PUT /receiving_reports/1.json
  def update
    respond_to do |format|
      if @receiving_report.update(receiving_report_params)
        format.html { redirect_to @receiving_report, notice: 'Receiving report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @receiving_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receiving_reports/1
  # DELETE /receiving_reports/1.json
  def destroy
    @receiving_report.destroy
    respond_to do |format|
      format.html { redirect_to receiving_reports_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receiving_report
      @receiving_report = ReceivingReport.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def receiving_report_params
      params.require(:receiving_report).permit(:report_id_id, :user_id_id, :read)
    end
end
