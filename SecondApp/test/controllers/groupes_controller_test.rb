require 'test_helper'

class GroupesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @groupe = groupes(:one)
  end

  test "should get index" do
    get groupes_url
    assert_response :success
  end

  test "should get new" do
    get new_groupe_url
    assert_response :success
  end

  test "should create groupe" do
    assert_difference('Groupe.count') do
      post groupes_url, params: { groupe: {  } }
    end

    assert_redirected_to groupe_url(Groupe.last)
  end

  test "should show groupe" do
    get groupe_url(@groupe)
    assert_response :success
  end

  test "should get edit" do
    get edit_groupe_url(@groupe)
    assert_response :success
  end

  test "should update groupe" do
    patch groupe_url(@groupe), params: { groupe: {  } }
    assert_redirected_to groupe_url(@groupe)
  end

  test "should destroy groupe" do
    assert_difference('Groupe.count', -1) do
      delete groupe_url(@groupe)
    end

    assert_redirected_to groupes_url
  end
end
