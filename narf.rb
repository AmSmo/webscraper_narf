require 'nokogiri'
require 'pry'
require 'httparty'

class Episode
    attr_reader :parsed_episode
    def initialize(url)
        @url = HTTParty.get(url)
        @parsed_episode = parse_page
        
    end

    def get_text(css)
        css.map {|ele| ele.text.strip}
    end

    def parse_page
        return Nokogiri::HTML(@url)
    end

    def title
        get_text(parsed_episode.css('h1').map { |ele| ele.text.strip }[0])
    end

    def airdate
        get_text(parsed_episode.css("[title^='See more']"))[0]
    end

    def rating
        get_text(parsed_episode.css('[itemprop="ratingValue"]'))[0]
    end
end