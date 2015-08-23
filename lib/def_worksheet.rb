module FFN
  class DEFWorksheet < PlayerWorksheet

    def initialize(position, worksheet, average_draft_positions)
      super(position, worksheet, average_draft_positions)

      @headers = display_headers + def_headers + ranking_headers
      @values = display_values + def_values
    end

    def populate_players
      @projections.count.times do |i|
        player = @projections[i]
        populate_stats(player, i)
        populate_ranking(player, i, 9)
      end
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

