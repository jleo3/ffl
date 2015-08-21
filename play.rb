require "pry"
require "fantasy_football_nerd"
require "dotenv"
require "google/api_client"
require "google_drive"

Dotenv.load
FFNerd.api_key = ENV["FFNERD_API_KEY"]

client = Google::APIClient.new(application_name: "FF Nerd",
                               application_version: "0.0.1")

auth = client.authorization
auth.client_id = ENV["GOOGLE_CLIENT_ID"]
auth.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
auth.scope = "https://docs.google.com/feeds/" + "https://www.googleapis.com/auth/drive " + "https://spreadsheets.google.com/feeds/"
auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
auth.refresh_token = ENV["GOOGLE_REFRESH_TOKEN"]

auth.refresh!

session = GoogleDrive.login_with_oauth(auth.access_token)
projections_doc = session.files.detect { |f| f.title == "2015 Projections FFN" }
worksheet = projections_doc.worksheets[0]
worksheet.title = "QB"
worksheet[1,1] = "Player"
worksheet[1,2] = "Team"
worksheet[1,3] = "Completions"
worksheet[1,4] = "Passing Yards"
worksheet[1,5] = "Passing TDs"
worksheet[1,6] = "INT"
worksheet[1,7] = "Rush Yards"
worksheet[1,8] = "Rush TDs"
worksheet[1,9] = "Fumbles Lost"

projections = FFNerd.draft_projections("QB")
projections.count.times do |i|
  player = projections[i]
  worksheet[i+2,1] = player.display_name
  worksheet[i+2,2] = player.team
  worksheet[i+2,3] = player.completions
  worksheet[i+2,4] = player.passing_yards
  worksheet[i+2,5] = player.passing_td
  worksheet[i+2,6] = player.passing_int
  worksheet[i+2,7] = player.rush_yards
  worksheet[i+2,8] = player.rush_td
  worksheet[i+2,9] = player.fumbles
end

worksheet.save



#top_pick = FFNerd.draft_projections("QB").first.displayName
#puts "the number one pick in the draft will be #{top_pick}"

=begin
puts("1. Open this page:\n%s\n\n" % auth.authorization_uri)
puts("2. Enter the authorization code shown in the page: ")

puts "access token: #{auth.access_token}"
puts "refresh token: #{auth.refresh_token}"
=end

