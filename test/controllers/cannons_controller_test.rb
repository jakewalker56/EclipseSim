require 'test_helper'

class CannonsControllerTest < ActionController::TestCase
  setup do
    @cannon = cannons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cannons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cannon" do
    assert_difference('Cannon.count') do
      post :create, cannon: {  }
    end

    assert_redirected_to cannon_path(assigns(:cannon))
  end

  test "should show cannon" do
    get :show, id: @cannon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cannon
    assert_response :success
  end

  test "should update cannon" do
    patch :update, id: @cannon, cannon: {  }
    assert_redirected_to cannon_path(assigns(:cannon))
  end

  test "should destroy cannon" do
    assert_difference('Cannon.count', -1) do
      delete :destroy, id: @cannon
    end

    assert_redirected_to cannons_path
  end
end
