require_relative "lib/rb_worksheet"
require_relative "lib/qb_worksheet"
require_relative "lib/sheet_populator"
require_relative "lib/google_api_wrapper"

require "pry"
require "dotenv"
require "fantasy_football_nerd"

Dotenv.load
FFNerd.api_key = ENV["FFNERD_API_KEY"]

google_api_wrapper = FFN::GoogleAPIWrapper.new
google_api_wrapper.login
sheets_doc = google_api_wrapper.retrieve_doc("2015 Projections FFN")

sheet_populator = FFN::SheetPopulator.new(sheets_doc)
sheet_populator.populate

