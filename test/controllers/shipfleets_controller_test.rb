require 'test_helper'

class ShipfleetsControllerTest < ActionController::TestCase
  setup do
    @shipfleet = shipfleets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shipfleets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shipfleet" do
    assert_difference('Shipfleet.count') do
      post :create, shipfleet: { amount: @shipfleet.amount, fleet_id: @shipfleet.fleet_id, ship_id: @shipfleet.ship_id }
    end

    assert_redirected_to shipfleet_path(assigns(:shipfleet))
  end

  test "should show shipfleet" do
    get :show, id: @shipfleet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shipfleet
    assert_response :success
  end

  test "should update shipfleet" do
    patch :update, id: @shipfleet, shipfleet: { amount: @shipfleet.amount, fleet_id: @shipfleet.fleet_id, ship_id: @shipfleet.ship_id }
    assert_redirected_to shipfleet_path(assigns(:shipfleet))
  end

  test "should destroy shipfleet" do
    assert_difference('Shipfleet.count', -1) do
      delete :destroy, id: @shipfleet
    end

    assert_redirected_to shipfleets_path
  end
end
