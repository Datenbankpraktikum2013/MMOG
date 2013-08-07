require 'test_helper'

class ReceivingReportsControllerTest < ActionController::TestCase
  setup do
    @receiving_report = receiving_reports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:receiving_reports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create receiving_report" do
    assert_difference('ReceivingReport.count') do
      post :create, receiving_report: { read: @receiving_report.read, report_id_id: @receiving_report.report_id_id, user_id_id: @receiving_report.user_id_id }
    end

    assert_redirected_to receiving_report_path(assigns(:receiving_report))
  end

  test "should show receiving_report" do
    get :show, id: @receiving_report
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @receiving_report
    assert_response :success
  end

  test "should update receiving_report" do
    patch :update, id: @receiving_report, receiving_report: { read: @receiving_report.read, report_id_id: @receiving_report.report_id_id, user_id_id: @receiving_report.user_id_id }
    assert_redirected_to receiving_report_path(assigns(:receiving_report))
  end

  test "should destroy receiving_report" do
    assert_difference('ReceivingReport.count', -1) do
      delete :destroy, id: @receiving_report
    end

    assert_redirected_to receiving_reports_path
  end
end
