class PostsController < ApplicationController
  
    def index
        @post = Post.all
    end

    def show
        @post = Post.find(params[:id])
    end

    def new
        @post = Post.new

        newsapi_response = File.read("newsapi.json")
        gnews_response = File.read("gnews.json")

        newsapi_obj = parseJSON(newsapi_response)
        gnews_obj = parseJSON(gnews_response)
    
        articles = gnews_obj + newsapi_obj

        @articles_array = []
        articles.each do |article| 
            title = article["title"]
            @articles_array.push(title)
        end
    end

    def create
        @post = Post.new(post_params)
        @post.user = User.find(1)

        if @post.save
            redirect_to posts_path
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[id])

        if @post.update(post_params)
            redirect_to @post
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        redirect_to root_path, status: :see_other
    end

    private
        def post_params
            params.require(:post).permit(:article, :body)
        end

        def parseJSON(json)
            json_parsed = JSON.parse(json)
            articles = json_parsed["articles"]
            return articles
        end

end
