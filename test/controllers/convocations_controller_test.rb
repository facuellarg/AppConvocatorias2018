require 'test_helper'

class ConvocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @convocation = convocations(:one)
  end

  test "should get index" do
    get convocations_url, as: :json
    assert_response :success
  end

  test "should create convocation" do
    assert_difference('Convocation.count') do
      post convocations_url, params: { convocation: { admin_id: @convocation.admin_id, description: @convocation.description, duration: @convocation.duration, end_date: @convocation.end_date, hours_per_week: @convocation.hours_per_week, name: @convocation.name, payout: @convocation.payout, type_student: @convocation.type_student, vacants: @convocation.vacants } }, as: :json
    end

    assert_response 201
  end

  test "should show convocation" do
    get convocation_url(@convocation), as: :json
    assert_response :success
  end

  test "should update convocation" do
    patch convocation_url(@convocation), params: { convocation: { admin_id: @convocation.admin_id, description: @convocation.description, duration: @convocation.duration, end_date: @convocation.end_date, hours_per_week: @convocation.hours_per_week, name: @convocation.name, payout: @convocation.payout, type_student: @convocation.type_student, vacants: @convocation.vacants } }, as: :json
    assert_response 200
  end

  test "should destroy convocation" do
    assert_difference('Convocation.count', -1) do
      delete convocation_url(@convocation), as: :json
    end

    assert_response 204
  end
end
