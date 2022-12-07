# frozen_string_literal: true

# This is the top level comment for news controller
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

    newsapi_response = request_url(newsapi_url)
    gnews_response = request_url(gnews_url)

    write_json_file(newsapi_response, gnews_response)

    # newsapi_response = File.read('newsapi_testdata.json')
    # gnews_response = File.read('gnews_testdata.json')

    parse_json(newsapi_response)
    parse_json(gnews_response)

    @articles = read_json_file
  end

  def refine
    @word = params[:search_string]
    articles = read_json_file

    result = WordMatch.containsWord(articles, @word.to_s)
    begin
      @articles = parse_json(result)
    rescue StandardError
      @articles = result.to_s
    end
  end

  private

  def write_json_file(newsapi_response, gnews_response)
    File.open('newsapi.json', 'w') { |f| f.write newsapi_response }
    File.open('gnews.json', 'w') { |f| f.write gnews_response }
  end

  def read_json_file
    newsapi_response = File.read('newsapi.json')
    gnews_response = File.read('gnews.json')

    newsapi_obj = parse_json(newsapi_response)
    gnews_obj = parse_json(gnews_response)

    gnews_obj + newsapi_obj
  end

  def parse_json(json)
    json_parsed = JSON.parse(json)
    json_parsed['articles']
  end

  def request_url(url)
    HTTParty.get(url).to_json
  end
end
