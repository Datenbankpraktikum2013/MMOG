require 'test_helper'

class ColonisationreportsControllerTest < ActionController::TestCase
  setup do
    @colonisationreport = colonisationreports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:colonisationreports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create colonisationreport" do
    assert_difference('Colonisationreport.count') do
      post :create, colonisationreport: { mode: @colonisationreport.mode }
    end

    assert_redirected_to colonisationreport_path(assigns(:colonisationreport))
  end

  test "should show colonisationreport" do
    get :show, id: @colonisationreport
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @colonisationreport
    assert_response :success
  end

  test "should update colonisationreport" do
    patch :update, id: @colonisationreport, colonisationreport: { mode: @colonisationreport.mode }
    assert_redirected_to colonisationreport_path(assigns(:colonisationreport))
  end

  test "should destroy colonisationreport" do
    assert_difference('Colonisationreport.count', -1) do
      delete :destroy, id: @colonisationreport
    end

    assert_redirected_to colonisationreports_path
  end
end
