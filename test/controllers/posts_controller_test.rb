# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test 'get posts page' do
    get '/posts'
    assert_response :success
  end

  test 'user should not view new post without sign in' do
    get '/posts/new'
    assert_response :redirect
  end

  test 'user should view new post when signed in' do
    sign_in users(:user1)
    get '/posts/new'
    assert_response :success
  end

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

  test 'User can not access My Posts page without login redirect' do
    get '/posts/user'
    assert_response :redirect
  end

  test 'User can get My Posts page if signed in' do
    sign_in users(:user1)
    get '/posts/user'
    assert_response :success
  end

  test 'Should delete post' do
    sign_in users(:user1)
    post = posts(:one)
    assert post.destroy
  end
end
