require 'test_helper'

class ShipcountsControllerTest < ActionController::TestCase
  setup do
    @shipcount = shipcounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shipcounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipcount" do
    assert_difference('Shipcount.count') do
      post :create, shipcount: { amount: @shipcount.amount, battlereport_id: @shipcount.battlereport_id, ship_id: @shipcount.ship_id, shipowner_time_type: @shipcount.shipowner_time_type }
    end

    assert_redirected_to shipcount_path(assigns(:shipcount))
  end

  test "should show shipcount" do
    get :show, id: @shipcount
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shipcount
    assert_response :success
  end

  test "should update shipcount" do
    patch :update, id: @shipcount, shipcount: { amount: @shipcount.amount, battlereport_id: @shipcount.battlereport_id, ship_id: @shipcount.ship_id, shipowner_time_type: @shipcount.shipowner_time_type }
    assert_redirected_to shipcount_path(assigns(:shipcount))
  end

  test "should destroy shipcount" do
    assert_difference('Shipcount.count', -1) do
      delete :destroy, id: @shipcount
    end

    assert_redirected_to shipcounts_path
  end
end
