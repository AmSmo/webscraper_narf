require 'pry'
require_relative 'narf.rb'
narf = Episode.new('https://www.imdb.com/title/tt0954793/?ref_=ttep_ep10')
parsed_episode = narf.parsed_episode
binding.pry
