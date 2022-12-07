require 'rubygems'
require 'json'
require 'pp'

class WordMatch

    def self.containsWord(articles, word)
        matches_arr = Array.new
        articles.each do |article|

            title = article["title"]
            description = article["description"]
            content = article["content"]

            isTitle = !title.nil?
            isDescription = !description.nil?
            isContent = !content.nil?

            found = false

            if isTitle
                if title.match(word)
                    found = true
                end
            end

            if isDescription
                if description.match(word)
                    found = true
                end
            end

            if isContent
                if content.match(word)
                    found = true
                end
            end

            if found
                matches_arr.push(article)
            end
        end

        if matches_arr.length < 1
            str = "No Matches Found"
            return str

        else
	    arr_length = matches_arr.length
	    articles_json = JSON.generate(matches_arr)
	    articles_obj = JSON.parse(articles_json)
	    append_json = {"status":"ok","totalResults":arr_length,"articles":articles_obj}
	    return json = JSON.generate(append_json)
        end

    end

end
