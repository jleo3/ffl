require 'fantasy_football_nerd'
require 'dotenv'
Dotenv.load

FFNerd.api_key = ENV["FFNERD_API_KEY"]

top_pick = FFNerd.draft_projections('QB').first.displayName
puts "the number one pick in the draft will be #{top_pick}"

