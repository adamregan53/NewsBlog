# frozen_string_literal: true

require 'test_helper'

class CreateNewCommentTest < ActionDispatch::IntegrationTest
  test 'create_new_comment_workflow' do
    sign_in users(:user1)
    get '/posts/new'
    assert_response :success

    post '/posts', params: {
      post: { article: 'Test Article Name', body: 'article body text', user_id: users(:user1) }
    }
    assert_response :redirect
    follow_redirect!
    assert_response :success

    comment = comments(:one)
    assert comment.save
    assert_response :success
  end

  test 'update_post_workflow' do
  end
end
