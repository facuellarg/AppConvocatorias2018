require 'test_helper'

class DependencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dependence = dependences(:one)
  end

  test "should get index" do
    get dependences_url, as: :json
    assert_response :success
  end

  test "should create dependence" do
    assert_difference('Dependence.count') do
      post dependences_url, params: { dependence: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show dependence" do
    get dependence_url(@dependence), as: :json
    assert_response :success
  end

  test "should update dependence" do
    patch dependence_url(@dependence), params: { dependence: {  } }, as: :json
    assert_response 200
  end

  test "should destroy dependence" do
    assert_difference('Dependence.count', -1) do
      delete dependence_url(@dependence), as: :json
    end

    assert_response 204
  end
end
