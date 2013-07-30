require 'test_helper'

class BuildingtypesControllerTest < ActionController::TestCase
  setup do
    @buildingtype = buildingtypes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:buildingtypes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create buildingtype" do
    assert_difference('Buildingtype.count') do
      post :create, buildingtype: { energieverbrauch: @buildingtype.energieverbrauch, name: @buildingtype.name, produktion: @buildingtype.produktion, stufe: @buildingtype.stufe }
    end

    assert_redirected_to buildingtype_path(assigns(:buildingtype))
  end

  test "should show buildingtype" do
    get :show, id: @buildingtype
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @buildingtype
    assert_response :success
  end

  test "should update buildingtype" do
    patch :update, id: @buildingtype, buildingtype: { energieverbrauch: @buildingtype.energieverbrauch, name: @buildingtype.name, produktion: @buildingtype.produktion, stufe: @buildingtype.stufe }
    assert_redirected_to buildingtype_path(assigns(:buildingtype))
  end

  test "should destroy buildingtype" do
    assert_difference('Buildingtype.count', -1) do
      delete :destroy, id: @buildingtype
    end

    assert_redirected_to buildingtypes_path
  end
end
