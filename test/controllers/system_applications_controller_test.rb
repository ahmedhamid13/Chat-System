require 'test_helper'

class SystemApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @system_application = system_applications(:one)
  end

  test "should get index" do
    get system_applications_url, as: :json
    assert_response :success
  end

  test "should create system_application" do
    assert_difference('SystemApplication.count') do
      post system_applications_url, params: { system_application: { chats_count: @system_application.chats_count, name: @system_application.name, token: @system_application.token } }, as: :json
    end

    assert_response 201
  end

  test "should show system_application" do
    get system_application_url(@system_application), as: :json
    assert_response :success
  end

  test "should update system_application" do
    patch system_application_url(@system_application), params: { system_application: { chats_count: @system_application.chats_count, name: @system_application.name, token: @system_application.token } }, as: :json
    assert_response 200
  end

  test "should destroy system_application" do
    assert_difference('SystemApplication.count', -1) do
      delete system_application_url(@system_application), as: :json
    end

    assert_response 204
  end
end
