require_relative "lib/player_worksheet"
require_relative "lib/qb_worksheet"
require_relative "lib/rb_worksheet"
require_relative "lib/wr_worksheet"
require_relative "lib/te_worksheet"
require_relative "lib/def_worksheet"
require_relative "lib/sheet_populator"
require_relative "lib/google_api_wrapper"

require "pry"
require "dotenv"
require "fantasy_football_nerd"

Dotenv.load
FFNerd.api_key = ENV["FFNERD_API_KEY"]
DOC_NAMES = ["2020 Projections LOC"]
google_api_wrapper = FFN::GoogleAPIWrapper.new
google_api_wrapper.login

DOC_NAMES.each do |doc_name|
  puts "Populating #{doc_name}..."
  sheets_doc = google_api_wrapper.retrieve_doc(doc_name)
  sheet_populator = FFN::SheetPopulator.new(sheets_doc)
  sheet_populator.populate
  puts "\nPopulating #{doc_name} complete!"
end

