require 'test_helper'

class SpyreportsControllerTest < ActionController::TestCase
  setup do
    @spyreport = spyreports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spyreports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spyreport" do
    assert_difference('Spyreport.count') do
      post :create, spyreport: { crystall: @spyreport.crystall, energy: @spyreport.energy, ore: @spyreport.ore, population: @spyreport.population, space_cash: @spyreport.space_cash }
    end

    assert_redirected_to spyreport_path(assigns(:spyreport))
  end

  test "should show spyreport" do
    get :show, id: @spyreport
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spyreport
    assert_response :success
  end

  test "should update spyreport" do
    patch :update, id: @spyreport, spyreport: { crystall: @spyreport.crystall, energy: @spyreport.energy, ore: @spyreport.ore, population: @spyreport.population, space_cash: @spyreport.space_cash }
    assert_redirected_to spyreport_path(assigns(:spyreport))
  end

  test "should destroy spyreport" do
    assert_difference('Spyreport.count', -1) do
      delete :destroy, id: @spyreport
    end

    assert_redirected_to spyreports_path
  end
end
