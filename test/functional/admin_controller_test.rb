require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  def test_index
    get :show, :id => Admin.first
    assert_template 'show'
  end
end
