require 'test_helper'

class TechstagesControllerTest < ActionController::TestCase
  setup do
    @techstage = techstages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:techstages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create techstage" do
    assert_difference('Techstage.count') do
      post :create, techstage: { level: @techstage.level, spyreport_id: @techstage.spyreport_id, technology_id: @techstage.technology_id }
    end

    assert_redirected_to techstage_path(assigns(:techstage))
  end

  test "should show techstage" do
    get :show, id: @techstage
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @techstage
    assert_response :success
  end

  test "should update techstage" do
    patch :update, id: @techstage, techstage: { level: @techstage.level, spyreport_id: @techstage.spyreport_id, technology_id: @techstage.technology_id }
    assert_redirected_to techstage_path(assigns(:techstage))
  end

  test "should destroy techstage" do
    assert_difference('Techstage.count', -1) do
      delete :destroy, id: @techstage
    end

    assert_redirected_to techstages_path
  end
end
