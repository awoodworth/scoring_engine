require 'test_helper'

class InjectsControllerTest < ActionController::TestCase
  setup do
    @inject = injects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:injects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inject" do
    assert_difference('Inject.count') do
      post :create, inject: { description: @inject.description, title: @inject.title }
    end

    assert_redirected_to inject_path(assigns(:inject))
  end

  test "should show inject" do
    get :show, id: @inject
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inject
    assert_response :success
  end

  test "should update inject" do
    patch :update, id: @inject, inject: { description: @inject.description, title: @inject.title }
    assert_redirected_to inject_path(assigns(:inject))
  end

  test "should destroy inject" do
    assert_difference('Inject.count', -1) do
      delete :destroy, id: @inject
    end

    assert_redirected_to injects_path
  end
end
