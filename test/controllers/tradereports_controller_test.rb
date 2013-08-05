require 'test_helper'

class TradereportsControllerTest < ActionController::TestCase
  setup do
    @tradereport = tradereports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tradereports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tradereport" do
    assert_difference('Tradereport.count') do
      post :create, tradereport: { crystal: @tradereport.crystal, ore: @tradereport.ore, space_cash: @tradereport.space_cash }
    end

    assert_redirected_to tradereport_path(assigns(:tradereport))
  end

  test "should show tradereport" do
    get :show, id: @tradereport
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tradereport
    assert_response :success
  end

  test "should update tradereport" do
    patch :update, id: @tradereport, tradereport: { crystal: @tradereport.crystal, ore: @tradereport.ore, space_cash: @tradereport.space_cash }
    assert_redirected_to tradereport_path(assigns(:tradereport))
  end

  test "should destroy tradereport" do
    assert_difference('Tradereport.count', -1) do
      delete :destroy, id: @tradereport
    end

    assert_redirected_to tradereports_path
  end
end
