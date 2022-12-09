# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'post should not save without article and body' do
    post = Post.new
    assert_not post.save
  end

  test 'post body should not be less than 10 characters' do
    post = posts(:three)
    assert_not post.save
  end

  test 'post should not save without user' do
    post = Post.new(article: 'test article', body: 'this is a test article body')
    assert_not post.save
  end

  test 'post will save with article, body and user' do
    post = Post.new(article: 'test article', body: 'this is a test article body', user_id: users(:user1).id)
    assert post.save
  end
end
