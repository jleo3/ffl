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

worksheet[1,1] = "ID"
worksheet[1,2] = "Player"
worksheet[1,3] = "Team"
worksheet[1,4] = "Completions"
worksheet[1,5] = "Passing Yards"
worksheet[1,6] = "Passing TDs"
worksheet[1,7] = "INT"
worksheet[1,8] = "Rush Yards"
worksheet[1,9] = "Rush TDs"
worksheet[1,10] = "Fumbles Lost"
worksheet[1,11] = "Position Rank"
worksheet[1,12] = "Overall Rank"

projections = FFNerd.draft_projections("QB")
rankings = FFNerd.ppr_draft_rankings.select { |x| x.position == "QB" }

projections.count.times do |i|
  player = projections[i]
  player_ranking = rankings.detect { |r| r.player_id == player.player_id }
  worksheet[i+2,1] = player.player_id
  worksheet[i+2,2] = player.display_name
  worksheet[i+2,3] = player.team
  worksheet[i+2,4] = player.completions
  worksheet[i+2,5] = player.passing_yards
  worksheet[i+2,6] = player.passing_td
  worksheet[i+2,7] = player.passing_int
  worksheet[i+2,8] = player.rush_yards
  worksheet[i+2,9] = player.rush_td
  worksheet[i+2,10] = player.fumbles
  worksheet[i+2,11] = player_ranking.position_rank
  worksheet[i+2,12] = player_ranking.overall_rank
end

worksheet.save

=begin

#<OpenStruct playerId="1932", completions="389", attempts="619", passingYards="4751", passingTD="35", passingInt="15", rushAtt="56", rushYards="255", rushTD="3", fumbles="5", fantasyPoints="334", displayName="Andrew Luck", team="IND", player_id="1932", passing_yards="4751", passing_td="35", passing_int="15", rush_att="56", rush_yards="255", rush_td="3", fantasy_points="334", display_name="Andrew Luck">
#

puts("1. Open this page:\n%s\n\n" % auth.authorization_uri)
puts("2. Enter the authorization code shown in the page: ")

puts "access token: #{auth.access_token}"
puts "refresh token: #{auth.refresh_token}"

LOC Scoring: =B3*0.3334+C3/50+D3*4+E3*-2+F3/20+G3*6

=end

