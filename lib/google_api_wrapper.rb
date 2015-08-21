require "google/api_client"
require "google_drive"

module FFN
  class GoogleAPIWrapper
    def login
      client = Google::APIClient.new(application_name: "FF Nerd",
                                     application_version: "0.0.1")

      auth = client.authorization
      auth.client_id = ENV["GOOGLE_CLIENT_ID"]
      auth.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
      auth.scope = "https://docs.google.com/feeds/" + "https://www.googleapis.com/auth/drive " + "https://spreadsheets.google.com/feeds/"
      auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
      auth.refresh_token = ENV["GOOGLE_REFRESH_TOKEN"]

      auth.refresh!
      @session = GoogleDrive.login_with_oauth(auth.access_token)
    end

    def retrieve_doc(name)
      @session.files.detect { |f| f.title == name }
    end
  end
end

=begin
When auth fails, you can recycle your tokens using this code:

puts("1. Open this page:\n%s\n\n" % auth.authorization_uri)
puts("2. Enter the authorization code shown in the page: ")

puts "access token: #{auth.access_token}"
puts "refresh token: #{auth.refresh_token}"
=end

