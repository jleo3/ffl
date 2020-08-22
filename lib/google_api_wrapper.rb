require "google_drive"

module FFN
  class GoogleAPIWrapper
    def login
      @session = GoogleDrive::Session.from_config("config.json")
      puts @session
    end

    def retrieve_doc(filename)
      @session.files.detect { |f| f.name == filename }
    end
  end
end
