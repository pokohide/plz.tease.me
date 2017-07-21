require 'test_helper'

class EmbedsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    get embeds_show_url
    assert_response :success
  end
end
