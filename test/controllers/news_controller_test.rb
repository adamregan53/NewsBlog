# frozen_string_literal: true

require 'test_helper'

class NewsControllerTest < ActionDispatch::IntegrationTest
  test 'should get news page' do
    get '/'
    assert_response :success
  end

  test '' do
  end
end
