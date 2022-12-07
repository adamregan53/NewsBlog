# frozen_string_literal: true

# This is the top level comment controller comment
class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post_id = @post.id
    @comment.user = User.find(1)

    if @comment.save
      redirect_to post_path(@post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy; end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end
