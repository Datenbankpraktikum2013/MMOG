require 'test_helper'

class SunsystemsControllerTest < ActionController::TestCase
  setup do
    @sunsystem = sunsystems(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sunsystems)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sunsystem" do
    assert_difference('Sunsystem.count') do
      post :create, sunsystem: { name: @sunsystem.name, y: @sunsystem.y }
    end

    assert_redirected_to sunsystem_path(assigns(:sunsystem))
  end

  test "should show sunsystem" do
    get :show, id: @sunsystem
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sunsystem
    assert_response :success
  end

  test "should update sunsystem" do
    patch :update, id: @sunsystem, sunsystem: { name: @sunsystem.name, y: @sunsystem.y }
    assert_redirected_to sunsystem_path(assigns(:sunsystem))
  end

  test "should destroy sunsystem" do
    assert_difference('Sunsystem.count', -1) do
      delete :destroy, id: @sunsystem
    end

    assert_redirected_to sunsystems_path
  end
end
