require 'test_helper'

class ShipBuildingQueuesControllerTest < ActionController::TestCase
  setup do
    @ship_building_queue = ship_building_queues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ship_building_queues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ship_building_queue" do
    assert_difference('ShipBuildingQueue.count') do
      post :create, ship_building_queue: { end_time: @ship_building_queue.end_time, planet_id: @ship_building_queue.planet_id, ship_id: @ship_building_queue.ship_id }
    end

    assert_redirected_to ship_building_queue_path(assigns(:ship_building_queue))
  end

  test "should show ship_building_queue" do
    get :show, id: @ship_building_queue
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ship_building_queue
    assert_response :success
  end

  test "should update ship_building_queue" do
    patch :update, id: @ship_building_queue, ship_building_queue: { end_time: @ship_building_queue.end_time, planet_id: @ship_building_queue.planet_id, ship_id: @ship_building_queue.ship_id }
    assert_redirected_to ship_building_queue_path(assigns(:ship_building_queue))
  end

  test "should destroy ship_building_queue" do
    assert_difference('ShipBuildingQueue.count', -1) do
      delete :destroy, id: @ship_building_queue
    end

    assert_redirected_to ship_building_queues_path
  end
end
