require 'test_helper'

class BattlereportsControllerTest < ActionController::TestCase
  setup do
    @battlereport = battlereports(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:battlereports)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create battlereport" do
    assert_difference('Battlereport.count') do
      post :create, battlereport: { attacker_id: @battlereport.attacker_id, attacker_planet_id: @battlereport.attacker_planet_id, defender_id: @battlereport.defender_id, defender_planet_id: @battlereport.defender_planet_id, fightdate: @battlereport.fightdate, stolen_crystal: @battlereport.stolen_crystal, stolen_ore: @battlereport.stolen_ore, stolen_space_cash: @battlereport.stolen_space_cash, winner_id: @battlereport.winner_id }
    end

    assert_redirected_to battlereport_path(assigns(:battlereport))
  end

  test "should show battlereport" do
    get :show, id: @battlereport
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @battlereport
    assert_response :success
  end

  test "should update battlereport" do
    patch :update, id: @battlereport, battlereport: { attacker_id: @battlereport.attacker_id, attacker_planet_id: @battlereport.attacker_planet_id, defender_id: @battlereport.defender_id, defender_planet_id: @battlereport.defender_planet_id, fightdate: @battlereport.fightdate, stolen_crystal: @battlereport.stolen_crystal, stolen_ore: @battlereport.stolen_ore, stolen_space_cash: @battlereport.stolen_space_cash, winner_id: @battlereport.winner_id }
    assert_redirected_to battlereport_path(assigns(:battlereport))
  end

  test "should destroy battlereport" do
    assert_difference('Battlereport.count', -1) do
      delete :destroy, id: @battlereport
    end

    assert_redirected_to battlereports_path
  end
end
