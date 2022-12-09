# frozen_string_literal: true

# This is the top leve comment for Posts controller
class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new

    @articles = read_articles
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    if @post.save
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
    @articles = read_articles
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path, status: :see_other
  end

  def user
    @post = Post.where(user_id: current_user)
  end

  private

  def read_articles
    newsapi_response = File.read('newsapi.json')
    gnews_response = File.read('gnews.json')

    newsapi_obj = parse_json(newsapi_response)
    gnews_obj = parse_json(gnews_response)

    articles = gnews_obj + newsapi_obj

    articles_array = []
    articles.each do |article|
      articles_array.push(article['title'])
    end
    articles_array
  end

  def post_params
    params.require(:post).permit(:article, :body)
  end

  def parse_json(json)
    json_parsed = JSON.parse(json)
    json_parsed['articles']
  end
end
