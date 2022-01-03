# frozen_string_literal: true

require "test_helper"

class SystemApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @system_application = system_applications(:one)
  end

  test "should get index" do
    get applications_url, as: :json
    assert_response :success
  end

  test "should show system_application" do
    get application_url(@system_application.token), as: :json
    assert_response :success
  end

  test "should create system_application" do
    assert_difference("SystemApplication.count") do
      post applications_url, params: { application: { name: @system_application.name } }, as: :json
    end

    assert_response 201
  end

  test "should update system_application" do
    patch application_url(@system_application.token), params: { application: { name: @system_application.name } }, as: :json
    assert_response 200
  end

  test "should destroy system_application" do
    assert_difference("SystemApplication.count", -1) do
      delete application_url(@system_application.token), as: :json
    end

    assert_response 204
  end
end
