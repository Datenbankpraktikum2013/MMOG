require 'test_helper'

class FleetsControllerTest < ActionController::TestCase
  setup do
    @fleet = fleets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fleets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fleet" do
    assert_difference('Fleet.count') do
      post :create, fleet: { arrival_time: @fleet.arrival_time, credit: @fleet.credit, crystal: @fleet.crystal, defense: @fleet.defense, departure_time: @fleet.departure_time, mission_id: @fleet.mission_id, offense: @fleet.offense, ore: @fleet.ore, ressource_capacity: @fleet.ressource_capacity, start_planet: @fleet.start_planet, storage_factor: @fleet.storage_factor, target_planet: @fleet.target_planet, user_id: @fleet.user_id, velocity_factor: @fleet.velocity_factor }
    end

    assert_redirected_to fleet_path(assigns(:fleet))
  end

  test "should show fleet" do
    get :show, id: @fleet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fleet
    assert_response :success
  end

  test "should update fleet" do
    patch :update, id: @fleet, fleet: { arrival_time: @fleet.arrival_time, credit: @fleet.credit, crystal: @fleet.crystal, defense: @fleet.defense, departure_time: @fleet.departure_time, mission_id: @fleet.mission_id, offense: @fleet.offense, ore: @fleet.ore, ressource_capacity: @fleet.ressource_capacity, start_planet: @fleet.start_planet, storage_factor: @fleet.storage_factor, target_planet: @fleet.target_planet, user_id: @fleet.user_id, velocity_factor: @fleet.velocity_factor }
    assert_redirected_to fleet_path(assigns(:fleet))
  end

  test "should destroy fleet" do
    assert_difference('Fleet.count', -1) do
      delete :destroy, id: @fleet
    end

    assert_redirected_to fleets_path
  end
end
