require 'test_helper'

class Groupes::StepsControllerControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get groupes_steps_controller_show_url
    assert_response :success
  end

  test "should get update" do
    get groupes_steps_controller_update_url
    assert_response :success
  end

end
