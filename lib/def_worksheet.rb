module FFN
  class DEFWorksheet < PlayerWorksheet

    def initialize(position, worksheet, average_draft_positions)
      super(position, worksheet, average_draft_positions)

      @ranking_column_start = 9
      @headers = display_headers + def_headers + ranking_headers
      @values = display_values + def_values
    end

    private

    def def_headers
      ["Sacks", "INT", "Fumble Rec", "TDs", "Special Teams TD"]
    end

    def def_values
      [:sacks, :interceptions, :fumble_rec, :td, :special_team_td]
    end

  end
end

