require 'test_helper'

class InjectResponsesControllerTest < ActionController::TestCase
  setup do
    @inject_response = inject_responses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inject_responses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inject_response" do
    assert_difference('InjectResponse.count') do
      post :create, inject_response: {  }
    end

    assert_redirected_to inject_response_path(assigns(:inject_response))
  end

  test "should show inject_response" do
    get :show, id: @inject_response
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @inject_response
    assert_response :success
  end

  test "should update inject_response" do
    patch :update, id: @inject_response, inject_response: {  }
    assert_redirected_to inject_response_path(assigns(:inject_response))
  end

  test "should destroy inject_response" do
    assert_difference('InjectResponse.count', -1) do
      delete :destroy, id: @inject_response
    end

    assert_redirected_to inject_responses_path
  end
end
