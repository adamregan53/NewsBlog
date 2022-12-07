# frozen_string_literal: true

class NewsController < ApplicationController
  include HTTParty

  NEWSAPI_BASE_URL = 'https://newsapi.org/v2/top-headlines?country=ie&pageSize=10&'
  NEWSAPI_API_KEY = "apiKey=#{ENV['NEWS_API_KEY']}".freeze

  GNEWS_BASE_URL = 'https://gnews.io/api/v4/top-headlines?'
  GNEWS_API_KEY = "token=#{ENV['GNEWS_API_KEY']}".freeze
  GNEWS_LANG = '&lang=en&country=us&max=10'

  def index
    newsapi_url = NEWSAPI_BASE_URL + NEWSAPI_API_KEY
    gnews_url = GNEWS_BASE_URL + GNEWS_API_KEY + GNEWS_LANG

    # newsapi_response = requestURL(newsapi_url)
    # gnews_response = requestURL(gnews_url)

    # File.open("newsapi.json", "w") { |f| f.write newsapi_response }
    # File.open("gnews.json", "w") { |f| f.write gnews_response}

    newsapi_response = File.read('newsapi_testdata.json')
    gnews_response = File.read('gnews_testdata.json')

    newsapi_obj = parseJSON(newsapi_response)
    gnews_obj = parseJSON(gnews_response)

    @articles = gnews_obj + newsapi_obj

    @@saved_articles = @articles
  end

  def refine
    @word = params[:search_string]
    @articles = @@saved_articles
    result = WordMatch.containsWord(@articles, @word.to_s)
    begin
      @articles = parseJSON(result)
    rescue StandardError
      @articles = result.to_s
    end
  end

  private

  def parseJSON(json)
    json_parsed = JSON.parse(json)
    json_parsed['articles']
  end

  def requestURL(url)
    HTTParty.get(url).to_json
  end
end
