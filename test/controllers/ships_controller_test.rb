require 'test_helper'

class ShipsControllerTest < ActionController::TestCase
  setup do
    @ship = ships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ship" do
    assert_difference('Ship.count') do
      post :create, ship: { construction_time: @ship.construction_time, consumption: @ship.consumption, credit_cost: @ship.credit_cost, crew_capacity: @ship.crew_capacity, crystal_cost: @ship.crystal_cost, defense: @ship.defense, fuel_capacity: @ship.fuel_capacity, name: @ship.name, offense: @ship.offense, ore_cost: @ship.ore_cost, ressource_capacity: @ship.ressource_capacity, velocity: @ship.velocity }
    end

    assert_redirected_to ship_path(assigns(:ship))
  end

  test "should show ship" do
    get :show, id: @ship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ship
    assert_response :success
  end

  test "should update ship" do
    patch :update, id: @ship, ship: { construction_time: @ship.construction_time, consumption: @ship.consumption, credit_cost: @ship.credit_cost, crew_capacity: @ship.crew_capacity, crystal_cost: @ship.crystal_cost, defense: @ship.defense, fuel_capacity: @ship.fuel_capacity, name: @ship.name, offense: @ship.offense, ore_cost: @ship.ore_cost, ressource_capacity: @ship.ressource_capacity, velocity: @ship.velocity }
    assert_redirected_to ship_path(assigns(:ship))
  end

  test "should destroy ship" do
    assert_difference('Ship.count', -1) do
      delete :destroy, id: @ship
    end

    assert_redirected_to ships_path
  end
end
