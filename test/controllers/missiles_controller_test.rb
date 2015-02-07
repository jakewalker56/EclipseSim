require 'test_helper'

class MissilesControllerTest < ActionController::TestCase
  setup do
    @missile = missiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:missiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create missile" do
    assert_difference('Missile.count') do
      post :create, missile: {  }
    end

    assert_redirected_to missile_path(assigns(:missile))
  end

  test "should show missile" do
    get :show, id: @missile
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @missile
    assert_response :success
  end

  test "should update missile" do
    patch :update, id: @missile, missile: {  }
    assert_redirected_to missile_path(assigns(:missile))
  end

  test "should destroy missile" do
    assert_difference('Missile.count', -1) do
      delete :destroy, id: @missile
    end

    assert_redirected_to missiles_path
  end
end
