require 'test_helper'

class TravelreportsControllerTest < ActionController::TestCase
  setup do
    @travelreport = travelreports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:travelreports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create travelreport" do
    assert_difference('Travelreport.count') do
      post :create, travelreport: { mode: @travelreport.mode }
    end

    assert_redirected_to travelreport_path(assigns(:travelreport))
  end

  test "should show travelreport" do
    get :show, id: @travelreport
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @travelreport
    assert_response :success
  end

  test "should update travelreport" do
    patch :update, id: @travelreport, travelreport: { mode: @travelreport.mode }
    assert_redirected_to travelreport_path(assigns(:travelreport))
  end

  test "should destroy travelreport" do
    assert_difference('Travelreport.count', -1) do
      delete :destroy, id: @travelreport
    end

    assert_redirected_to travelreports_path
  end
end
