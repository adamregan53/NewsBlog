# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  test "comment does not save without body" do
    comment = Comment.new
    assert_not comment.save
  end

  test "comment saves with body" do
    comment = comments(:one)
    assert comment.save
  end

  test "comment should delete" do
    comment = comments(:one)
    assert comment.delete
  end
end
