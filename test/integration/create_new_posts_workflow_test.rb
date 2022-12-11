require "test_helper"

class CreateNewPostsWorkflowTest < ActionDispatch::IntegrationTest
  test 'can create a new post' do
    sign_in users(:user1)
    get '/posts/new'
    assert_response :success

    post '/posts', params: {
      post: { article: 'Test Article Name', body: 'article body text', user_id: users(:user1) }
    }
    assert_response :redirect
    follow_redirect!
    assert_response :success
  end

end
